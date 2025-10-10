extends CollisionShape3D

@onready var parentArea := $".."
@onready var parentMesh := $"../../Mesh"

var meshMaterial: StandardMaterial3D
@export var awareColor: Color
@export var sleepingColor: Color

var spaceState: PhysicsDirectSpaceState3D

func _ready() -> void:
	# Get the Material
	var mat = parentMesh.get_active_material(0) as StandardMaterial3D
	assert(mat != null, "MeshInstance3D has no material assigned!")
	meshMaterial = mat.duplicate(true) as StandardMaterial3D # deep duplicate
	parentMesh.set_surface_override_material(0, meshMaterial)
	
	spaceState = get_world_3d().get_direct_space_state()
	assert(spaceState != null, "Space State is fucked")
	
func _physics_process(delta: float) -> void:
	var playerAround: bool = ProcessBodyTracking()
	if playerAround && meshMaterial.albedo_color != awareColor:
		meshMaterial.albedo_color = awareColor
	elif !playerAround && meshMaterial.albedo_color == awareColor:
		meshMaterial.albedo_color = sleepingColor
		
func ProcessBodyTracking() -> bool:
	for body in parentArea.get_overlapping_bodies():
		if "Player" not in body.get_groups():
			continue
		# Raycast to see if we can actually see the player.
		var playerPos := (body as Node3D).global_transform.origin
		
		# This has changed in Godot 4.
		var params = PhysicsRayQueryParameters3D.new()
		params.from = global_transform.origin
		params.to = playerPos
		var raycastResult = spaceState.intersect_ray(params)
		
		# Check to see if it's the player.
		if raycastResult:
			var hitObject = raycastResult["collider"]
			if !hitObject.is_in_group("Player"):
				print("I can't see them")
				continue
		
		return true
		
	# No bodies found
	return false

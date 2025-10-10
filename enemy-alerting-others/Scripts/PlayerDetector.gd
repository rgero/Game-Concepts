extends CollisionShape3D

@onready var parentArea := $".."
@onready var enemyNode: CharacterBody3D = $"../.."

var spaceState: PhysicsDirectSpaceState3D
var wasWarned: bool

func _ready() -> void:
	spaceState = get_world_3d().get_direct_space_state()
	assert(spaceState != null, "Space State is fucked")
	
func _physics_process(delta: float) -> void:
	var playerAround: bool = ProcessBodyTracking()
	if playerAround:
		enemyNode.UpdateColor(GlobalStatus.EnemyStatus.ALERT)
	elif wasWarned:
		enemyNode.UpdateColor(GlobalStatus.EnemyStatus.WARNED)
	elif !playerAround and !wasWarned:
		enemyNode.UpdateColor(GlobalStatus.EnemyStatus.IDLE)
		
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
				continue
		
		return true
		
	# No bodies found
	return false

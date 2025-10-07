extends CollisionShape3D

@onready var parentArea := $".."
@onready var parentMesh := $"../../Mesh"

var meshMaterial: StandardMaterial3D
@export var awareColor: Color
@export var sleepingColor: Color

func _ready() -> void:
	parentArea.body_entered.connect(ProcessBodyEnter)
	parentArea.body_exited.connect(ProcessBodyExit)
	
	# Get the Material
	meshMaterial = parentMesh.get_active_material(0) as StandardMaterial3D
	assert(meshMaterial != null, "MeshInstance3D has no material assigned!")

func ProcessBodyEnter(body):
	if "Player" not in body.get_groups():
		return;
		
	print("Player Entered? I am mad!")
	if meshMaterial.albedo_color != awareColor:
		meshMaterial.albedo_color = awareColor
	
func ProcessBodyExit(body):
	if "Player" not in body.get_groups():
		return;
		
	print("Player Exited! No longer Mad")
	if meshMaterial.albedo_color == awareColor:
		meshMaterial.albedo_color = sleepingColor

extends CharacterBody3D

var currentStatus = GlobalStatus.EnemyStatus.IDLE

var meshMaterial: StandardMaterial3D
@export var awareColor: Color
@export var alertedColor: Color
@export var sleepingColor: Color

@onready var bodyMesh: MeshInstance3D = $Mesh

func _ready() -> void:
	# Get the Material
	meshMaterial = bodyMesh.get_active_material(0) as StandardMaterial3D
	assert(meshMaterial != null, "MeshInstance3D has no material assigned!")
	
	# By Default make it sleep
	meshMaterial.albedo_color = sleepingColor

func UpdateColor(status: GlobalStatus.EnemyStatus) -> void:
	if currentStatus == status:
		return;

	var targetColor: Color	
	if status == GlobalStatus.EnemyStatus.ALERT:
		currentStatus = GlobalStatus.EnemyStatus.ALERT
		targetColor = alertedColor
	elif status == GlobalStatus.EnemyStatus.WARNED:
		currentStatus = GlobalStatus.EnemyStatus.WARNED
		targetColor = awareColor
	else:
		currentStatus = GlobalStatus.EnemyStatus.IDLE
		targetColor = sleepingColor
	meshMaterial.albedo_color = targetColor
	print("Color Updated")

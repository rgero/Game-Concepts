extends Area3D

@export var aggressionRadius: float = 3.0
@onready var detectionShape = $DetectionShape

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detectionSphere := detectionShape.shape as SphereShape3D
	detectionSphere.radius = aggressionRadius

extends Node3D

@onready var alertShape: CollisionShape3D = $"Alert Radius/Alert Shape"
@onready var detectionShape: CollisionShape3D = $"Detection Radius/Detection Shape"

@export var detectionRadius := 3.0
@export var alertRadius := 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var detectionSphere := detectionShape.shape as SphereShape3D
	detectionSphere.radius = detectionRadius
	
	var alertSphere := alertShape.shape as SphereShape3D
	alertSphere.radius = alertRadius

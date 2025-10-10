extends CharacterBody3D

@onready var warningTimer: Timer = $WarningTimer

var meshMaterial: StandardMaterial3D
@export var awareColor: Color
@export var alertedColor: Color
@export var sleepingColor: Color
@export var bodyMesh: MeshInstance3D

var currentStatus = GlobalStatus.EnemyStatus.IDLE
var nearbyBodies: Array = []

func _ready() -> void:
	var mat := bodyMesh.get_active_material(0) as StandardMaterial3D
	assert(mat != null, "MeshInstance3D has no material assigned!")
	meshMaterial = mat.duplicate(true) as StandardMaterial3D
	bodyMesh.set_surface_override_material(0, meshMaterial)
	
	meshMaterial.albedo_color = sleepingColor
	
	warningTimer.connect("timeout", Callable(self, "_OnWarnedTimeout"))

func UpdateColor(status: GlobalStatus.EnemyStatus) -> void:
	var needsRefresh = status == GlobalStatus.EnemyStatus.WARNED and currentStatus == GlobalStatus.EnemyStatus.WARNED
	if currentStatus == status and not needsRefresh:
		return

	currentStatus = status
	var targetColor: Color

	match status:
		GlobalStatus.EnemyStatus.ALERT:
			targetColor = alertedColor
			AlertNearby()
			if warningTimer.is_stopped() == false:
				warningTimer.stop()
		GlobalStatus.EnemyStatus.WARNED:
			targetColor = awareColor
			warningTimer.start() # restart the timer on every warn
		GlobalStatus.EnemyStatus.IDLE:
			targetColor = sleepingColor
			if warningTimer.is_stopped() == false:
				warningTimer.stop()

	meshMaterial.albedo_color = targetColor

func Warn() -> void:
	if currentStatus != GlobalStatus.EnemyStatus.ALERT:
		UpdateColor(GlobalStatus.EnemyStatus.WARNED)

func AlertNearby() -> void:
	for body in nearbyBodies:
		if body.has_method("Warn"):
			body.Warn()

func _on_alert_radius_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy") and body != self:
		nearbyBodies.append(body)

func _OnWarnedTimeout() -> void:
	if currentStatus == GlobalStatus.EnemyStatus.WARNED:
		UpdateColor(GlobalStatus.EnemyStatus.IDLE)

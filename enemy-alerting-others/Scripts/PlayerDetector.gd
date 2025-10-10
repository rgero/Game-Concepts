extends CollisionShape3D

@onready var parentArea := $".."
@onready var enemyNode: CharacterBody3D = $"../../.."

var spaceState: PhysicsDirectSpaceState3D

func _ready() -> void:
	spaceState = get_world_3d().get_direct_space_state()
	assert(spaceState != null, "Space State is null")

func _physics_process(delta: float) -> void:
	if CanSeePlayer():
		enemyNode.UpdateColor(GlobalStatus.EnemyStatus.ALERT)
	elif enemyNode.currentStatus != GlobalStatus.EnemyStatus.WARNED:
		enemyNode.UpdateColor(GlobalStatus.EnemyStatus.IDLE)

# Detect if a player is visible
func CanSeePlayer() -> bool:
	for body in parentArea.get_overlapping_bodies():
		if "Player" not in body.get_groups():
			continue

		var playerPos = (body as Node3D).global_transform.origin

		var params = PhysicsRayQueryParameters3D.new()
		params.from = global_transform.origin
		params.to = playerPos
		var raycastResult = spaceState.intersect_ray(params)

		if raycastResult and raycastResult["collider"].is_in_group("Player"):
			return true

	return false

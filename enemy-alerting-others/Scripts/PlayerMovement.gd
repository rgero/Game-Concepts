extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_force: float = 10.0
@export var gravity: float = 20.0
@export var mouse_sensitivity: float = 0.003

var yaw: float = 0.0
var pitch: float = 0.0

@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, -1.2, 1.2)
		rotation.y = yaw
		camera.rotation.x = pitch

func _physics_process(delta):
	var direction = Vector3.ZERO

	# Input movement relative to camera facing
	var forward = -transform.basis.z
	var right = transform.basis.x

	if Input.is_action_pressed("move_forward"):
		direction += forward
	if Input.is_action_pressed("move_backward"):
		direction -= forward
	if Input.is_action_pressed("move_left"):
		direction -= right
	if Input.is_action_pressed("move_right"):
		direction += right

	direction = direction.normalized()

	# Apply horizontal movement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		# Jump
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force

	# Apply motion
	move_and_slide()
	
	# Check for quit
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

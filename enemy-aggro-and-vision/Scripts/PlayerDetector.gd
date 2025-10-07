extends CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".body_entered.connect(ProcessBodyEnter)
	$"..".body_exited.connect(ProcessBodyExit)

func ProcessBodyEnter(body):
	print("Body Entered? I am mad!")
	
func ProcessBodyExit(body):
	print("Body Exited! No longer Mad")

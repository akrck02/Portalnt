extends CharacterBody3D

@onready var camera : Camera3D = $Camera
@onready var light : DirectionalLight3D = $DirectionalLight3D
@export var speed = 14
var target_velocity = Vector3.ZERO

var mouse_sens_x = 0.006
var mouse_sens_y = 0.003
var camera_anglev= 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_move()

func _move():
	
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
		return
	
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed(Controls.UP):
		direction.z -= speed
	if Input.is_action_pressed(Controls.DOWN):
		direction.z += speed
	if Input.is_action_pressed(Controls.LEFT):
		direction.x -= speed
	if Input.is_action_pressed(Controls.RIGHT):
		direction.x += speed

	# Ground Velocity
	direction = direction.rotated(Vector3(0,1,0), rotation.y)
	
	# Moving the Character
	velocity = direction
	move_and_slide()


func _input(event):
	_moveCamera(event)


func _moveCamera(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sens_y)
		camera.rotate_x(-event.relative.y * mouse_sens_y)

 

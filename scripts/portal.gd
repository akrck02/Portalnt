extends Node3D
class_name Portal

enum Colors {
	Blue,
	Orange
}

@onready var shape : CSGCylinder3D = $Shape
@onready var animator : AnimationPlayer = $AnimationPlayer

@export var color : Colors = Colors.Blue
@export var brother : Portal = null

var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	animator.play("idle")
	
	match color:
		Colors.Blue: 
			shape.material_override = load("res://materials/portal_blue.tres")
		Colors.Orange:
			shape.material_override = load("res://materials/portal_orange.tres")

func teleport(body : CharacterBody3D):
	active = false
	body.position = self.position
	body.rotation = self.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _on_area_3d_body_entered(body):
	
	if not active:
		print("Portal is not active now")
		return
	
	if brother == null:
		print("No brother assigned to this portal")
		return

	if brother.has_method("teleport"):
		brother.teleport(body)


func _on_area_3d_body_exited(body):
	active = true

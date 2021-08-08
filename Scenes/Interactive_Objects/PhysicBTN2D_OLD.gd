extends Node2D

onready var btn = get_node("btn")
onready var sim = get_node("Line2D")
export var is_push_type : bool = true
var triger : bool = false
var is_down : bool = false
var is_up : bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func btn_is_on():
	sim.modulate.a = 1

func btn_is_off():
	sim.modulate.a = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if btn.position.y >= -0.06:
		btn.applied_force = Vector2(0,-50).rotated(rotation)
	if is_push_type:
		if btn.position.y > 2.5:
			triger = true
			btn_is_on()
		else:
			triger = false
			btn_is_off()
	else:
		if btn.position.y >= 2.5:
			is_down = true
		elif btn.position.y >= -0.06 && is_down:
			is_up = true
		if is_down && is_up && btn.position.y >= -0.06:
			is_down = false
			is_up = false
			triger = !triger
		if triger:
			btn_is_on()
		else:
			btn_is_off()



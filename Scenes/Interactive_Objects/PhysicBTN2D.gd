extends Node2D

onready var btn = get_node("btn")
onready var sim = get_node("Line2D")
onready var coll_poly = get_node("btn/CollisionPolygon2D")
export var is_push_type : bool = true
export var force : int = 50
export var triger : bool = false
var is_down : bool = false
var is_up : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var polygon = Polygon2D.new()
	polygon.polygon = coll_poly.polygon
	polygon.color = Color(1,1,1,0.7)
	coll_poly.add_child(polygon)


func btn_is_on():
	sim.modulate.a = 1

func btn_is_off():
	sim.modulate.a = 0.2

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if btn.position.y >= -5:
		btn.applied_force = Vector2(0,-force).rotated(rotation)
	if is_push_type:
		if btn.position.y > -2.5:
			triger = true
			btn_is_on()
		else:
			triger = false
			btn_is_off()
	else:
		if btn.position.y >= -2.5:
			is_down = true
		elif btn.position.y <= -4.5 && is_down:
			is_up = true
		if is_down && is_up && btn.position.y <= -4.5:
			is_down = false
			is_up = false
			triger = !triger
		if triger:
			btn_is_on()
		else:
			btn_is_off()



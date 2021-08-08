extends KinematicBody2D

onready var col = get_node("CollisionShape2D")
onready var poly = get_node("Polygon2D")
onready var anim = get_node("AnimationPlayer")
onready var parent = get_parent()
onready var first_time : bool = true

onready var one : bool = false
onready var change : bool = false
export var back_and_forward : bool = false


func _ready():
	poly.polygon = [Vector2(-col.shape.extents.x + col.position.x,-col.shape.extents.y + col.position.y),Vector2(col.shape.extents.x + col.position.x,-col.shape.extents.y + col.position.y),Vector2(col.shape.extents.x + col.position.x,col.shape.extents.y + col.position.y),Vector2(-col.shape.extents.x + col.position.x,col.shape.extents.y + col.position.y)]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if first_time && !back_and_forward:
		if parent.triger:
			print("animation is playing")
			anim.play("move")
			first_time = false
	if back_and_forward:
		if !change && parent.triger && !one:
			anim.play("move")
			one = true
			change = true
		if !change && parent.triger && one:
			anim.play_backwards("move")
			one = false
			change = true
		if !parent.triger:
			change = false
	pass

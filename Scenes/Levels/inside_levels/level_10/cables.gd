extends Node2D

onready var line_1 = get_node("Line2D")
onready var line_2 = get_node("Line2D2")
onready var line_3 = get_node("Line2D3")
onready var line_4 = get_node("Line2D4")

onready var boss = get_node("../Boss_1/RigidBody2D")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var boss_pos = boss.get_global_position()
	line_1.points[1] = boss_pos
	line_2.points[1] = boss_pos
	line_3.points[1] = boss_pos
	line_4.points[1] = boss_pos
	pass

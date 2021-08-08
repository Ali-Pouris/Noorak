extends Node2D

onready var rig_arr : Array = []
onready var rig_pos : Array
onready var line = Line2D.new()

func _ready():
	line.z_index = -1
	line.set_width(1)
	line.default_color = Color(0,0,0)
	add_child(line)
	
	for child in get_children():
		if child.get_class() == "RigidBody2D":
				rig_arr.append(child)




func _physics_process(_delta):
	for r in rig_arr:
		rig_pos.append(r.position)
	line.set_points(rig_pos)
	rig_pos.clear()
	pass

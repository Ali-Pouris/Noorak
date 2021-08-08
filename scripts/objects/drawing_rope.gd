extends Node2D

onready var points : PoolVector2Array


func _ready():
	for child in get_children():
		if child.get_class() == "RigidBody2D":
			points = [Vector2(-child.get_child(0).shape.extents.x,-child.get_child(0).shape.extents.y),Vector2(child.get_child(0).shape.extents.x,-child.get_child(0).shape.extents.y),Vector2(child.get_child(0).shape.extents.x,child.get_child(0).shape.extents.y),Vector2(-child.get_child(0).shape.extents.x,child.get_child(0).shape.extents.y)]


func _draw():
	for child in get_children():
		if child.get_class() == "RigidBody2D":
			draw_set_transform(child.position,child.rotation,child.scale)
			draw_colored_polygon(points,Color(0,0,0,1))


func _process(_delta):
	update()



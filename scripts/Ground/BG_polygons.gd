extends Node2D

onready var points : Array
onready var colors : Array
onready var child_count : int = get_child_count()

func _ready():
	visible = true
	for child in get_children():
		points.append(child.polygon)
		colors.append(child.color)
		child.queue_free()

func _draw():
	for n in child_count:
		draw_colored_polygon(points[n],colors[n])

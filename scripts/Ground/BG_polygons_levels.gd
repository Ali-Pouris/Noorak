extends Node2D

onready var points : Array
onready var colors : Array
onready var child_count : int = get_child_count()

func _ready():
	visible = true
	for child in get_children():
		if child.is_in_group("bg_back"):
			child.color = PlayerVars.bg_color_back
		elif child.is_in_group("bg_mid"):
			child.color = PlayerVars.bg_color_mid
		elif child.is_in_group("bg_front"):
			child.color = PlayerVars.bg_color_front
		elif child.is_in_group("bg_light"):
			child.color = PlayerVars.bg_color_light
		points.append(child.polygon)
		colors.append(child.color)
		child.queue_free()

func _draw():
	for n in child_count:
		draw_colored_polygon(points[n],colors[n])

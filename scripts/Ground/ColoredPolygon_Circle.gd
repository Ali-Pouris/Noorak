extends StaticBody2D
#Draw Colored Polygons for CircleShapes2D ONLY!!!
func _draw():
	for child in get_children():
		draw_circle(child.position,child.shape.radius,Color(0,0,0,1))

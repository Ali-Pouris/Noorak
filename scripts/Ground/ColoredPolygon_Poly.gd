extends StaticBody2D
#Draw Colored Polygons for CollisionPolygon2D ONLY!!!
func _draw():
	for child in get_children():
		draw_set_transform(child.position,child.rotation,child.scale)
		draw_colored_polygon(child.polygon,Color(0,0,0,1))


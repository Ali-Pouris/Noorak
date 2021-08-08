extends StaticBody2D
#Draw Colored Polygons for CollisionPolygon2D ONLY!!!
func _draw():
	draw_set_transform(get_child(0).position,get_child(0).rotation,get_child(0).scale)
	draw_colored_polygon(get_child(0).polygon,Color(0,0,0,1))


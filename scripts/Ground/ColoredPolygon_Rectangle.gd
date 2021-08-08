extends StaticBody2D
#Draw Colored Polygons for RectangleShapes2D ONLY!!!
func _draw():
	for child in get_children():
		draw_set_transform(child.position,child.rotation,child.scale)
		draw_colored_polygon([Vector2(-child.shape.extents.x,-child.shape.extents.y),Vector2(child.shape.extents.x,-child.shape.extents.y),Vector2(child.shape.extents.x,child.shape.extents.y),Vector2(-child.shape.extents.x,child.shape.extents.y)],Color(0,0,0,1))

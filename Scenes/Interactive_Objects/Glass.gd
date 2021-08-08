extends CollisionPolygon2D

onready var parent = get_parent()
onready var is_happend : bool = false

export var shard_poly_colors = Color(1,1,1,0.7)
export var is_complex = false

var tween = Tween.new()
var poly_color = Polygon2D.new()
var is_added : bool = false

onready var line_points: Array



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	poly_color.polygon = polygon
	poly_color.color = shard_poly_colors
	poly_color.color.a = 0.7
	add_child(poly_color)
	
	var poly_line = get_polygon()

	for i in range(0 , poly_line.size()):
		#draw_line(poly_line[i-1] , poly_line[i], OutLine , Width)
		line_points.append(poly_line[i])
	line_points.append(poly_line[0])
	line_points.append(poly_line[1])


func _draw():
	draw_polyline(line_points,Color(1,1,1,0.7),1)


func explode():
	var points = polygon
	var delaunay_points_one = Geometry.triangulate_polygon(points)
	
	if not delaunay_points_one:
		print("serious error occurred no delaunay points found")
	#find the midlle point of each triangle and add it to points
	for index in len(delaunay_points_one) / 3:
		var shard_pool_one = PoolVector2Array()
		var Ox = 0
		var Oy = 0
		for n in range(3):
			shard_pool_one.append(points[delaunay_points_one[(index * 3) + n]])
			Ox += shard_pool_one[n].x
			Oy += shard_pool_one[n].y
		points.append(Vector2(Ox / 3, Oy / 3))
	
	var delaunay_points_two = Geometry.triangulate_delaunay_2d(points)
	
	if is_complex:
		delaunay_points_two = delaunay_points_one
	
	for index in len(delaunay_points_two) / 3:
		var shard_pool = PoolVector2Array()
		
		# loop over the three points in our triangle
		for n in range(3):
			shard_pool.append(points[delaunay_points_two[(index * 3) + n]])
		
		var shard_polygon = Polygon2D.new()
		var shard_collision_polygon = CollisionPolygon2D.new()
		var shard_rigidbody = RigidBody2D.new()

		
		shard_polygon.polygon = shard_pool
		shard_collision_polygon.polygon = shard_pool
		shard_rigidbody.applied_torque = round(rand_range(-1,1))
		shard_rigidbody.mass = 0.4
		shard_rigidbody.gravity_scale = 0.2
		shard_rigidbody.set_collision_layer_bit(0,false)
		shard_rigidbody.set_collision_mask_bit(0,false)
		shard_rigidbody.set_collision_layer_bit(2,true)
		shard_rigidbody.set_collision_mask_bit(2,true)
		shard_rigidbody.add_child(shard_polygon)
		shard_rigidbody.add_child(shard_collision_polygon)
		
		shard_polygon.color = shard_poly_colors
		
#		add_child(shard_rigidbody)
#		shard_polygon.add_child(tween)
		call_deferred("add_child", shard_rigidbody)
		if is_added == false:
			call_deferred("add_child", tween)
			is_added = true
		
		tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.5, tween.TRANS_LINEAR, tween.EASE_OUT_IN)
		shard_rigidbody.apply_central_impulse(Vector2(5,0).rotated(deg2rad(rand_range(0,360))))
	self.polygon = [Vector2.ZERO]
	yield(get_tree().create_timer(1), "timeout")
	tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	parent.queue_free()
#	for ch in get_children():
#		print(ch.get_class())
#		if !ch.get_class() == "Polygon2D":
#			ch.queue_free()


func destroy_the_glass():
	is_happend = true
	for n in range(20):
		parent.set_collision_layer_bit(n, false)
		parent.set_collision_mask_bit(n, false)
	poly_color.hide()
	
	#Deleting the pinjoint conected to the glass before deleting the glass itself
	var twodots = "../"
	for child in get_parent().get_parent().get_children():
		if child.is_in_group("GlassPinJoint"):
			if child.get_node_a() == twodots + get_parent().name or child.get_node_b() == twodots + get_parent().name:
				child.queue_free()
	
	explode()



func _on_RigidBody2D2_body_entered(body):
#	print(body.get_collision_layer_bit(9))
#	print(body.get_linear_velocity().length())
#	print(body.name)
	if !is_happend:
		if parent.get_linear_velocity().length() > 40:
			destroy_the_glass()
		elif body.get_collision_layer_bit(9) == true && body.get_collision_mask_bit(9) == true:
			destroy_the_glass()
		elif body.get_collision_layer_bit(9) == true && body.get_linear_velocity().length() > 80:
			destroy_the_glass()
		elif body.get_collision_mask_bit(9) == true:
			destroy_the_glass()


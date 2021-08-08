extends RayCast2D

onready var line = get_node("Line2D")
onready var line2 = get_node("Line2D2")
onready var particle = get_node("Line2D/CPUParticles2D")

#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding():
		line.points[1] = get_collision_point() - get_global_position()
		line2.points[1] = line.points[1]
		line.rotation = line.points[1].angle_to(Vector2(1,0))
		line2.rotation = line.rotation
		particle.set_position(line.points[1])
		particle.rotation = get_global_rotation() + deg2rad(180)
		if get_collider() != null:
			if get_collider().has_signal("lezer_hiting_player") && PlayerVars.player_is_dead == false:
				PlayerVars.player_must_die = true
	else:
		line.rotation = 0
		line2.rotation = 0
		line.points[1] = get_cast_to()
		line2.points[1] = line.points[1]
		particle.set_position(cast_to)
		particle.rotation = deg2rad(180)

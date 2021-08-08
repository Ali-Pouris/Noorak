extends RigidBody2D

var projectile_speed = 400
var life_time = 0.2

func _ready():
	apply_impulse(Vector2(),Vector2(projectile_speed,0).rotated(rotation))
	SelfDestruct()
	if PlayerVars.invisible_theme:
		get_node("Sprite").modulate.a = 0
	else:
		get_node("Sprite").modulate = PlayerVars.balls_color
		get_node("Sprite").modulate.a = 1


func SelfDestruct():
	yield(get_tree().create_timer(life_time),"timeout")
	queue_free()

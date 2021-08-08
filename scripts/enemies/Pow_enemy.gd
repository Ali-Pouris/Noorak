extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.get_parent().name == "player":
		#print(body.get_parent().name)
		apply_impulse(get_global_position(),Vector2(200,0).rotated(get_angle_to(body.position)))

extends Node2D

export var one_time_trigered : bool = false
onready var triger : bool = false
onready var sprite = get_node("Sprite")

func _on_Area2D_body_entered(body):
#	if body.name == "PlayerRigidBody":
#		triger = true
#		sprite.set_frame(1)
	triger = true
	sprite.set_frame(1)

func _on_Area2D_body_exited(body):
#	if body.name == "PlayerRigidBody":
#		triger = false
#		if !one_time_trigered:
#			sprite.set_frame(0)
	
	if !one_time_trigered:
		triger = false
		sprite.set_frame(0)

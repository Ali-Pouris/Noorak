extends Area2D

#========remember to set checkpoint_number
export var checkpoint_number : int = 1
onready var checkpoint_position : Vector2 = get_node("Position2D").get_global_position()

func _on_CheckPoint_body_entered(body):
	if body.name == "PlayerRigidBody" && checkpoint_number > PlayerVars.checkpoint_number:
		PlayerVars.checkpoint_number = checkpoint_number
		PlayerVars.checkpoint_position = checkpoint_position
#		print("checkpiont")

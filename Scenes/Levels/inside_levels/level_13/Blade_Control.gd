extends Node2D

onready var btn = get_node("PhysicBTN2D2")
onready var move_anim = get_node("AnimationPlayer")
onready var rotate_anim = get_node("Blade/AnimationPlayer2")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if btn.triger:
		move_anim.play("move")
		rotate_anim.play("rotate")
	pass


func _on_Blade_body_entered(body):
	if body.name == "PlayerRigidBody":
		if PlayerVars.player_is_dead == false:
			PlayerVars.player_must_die = true

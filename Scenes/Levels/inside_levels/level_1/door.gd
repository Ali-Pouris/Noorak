extends KinematicBody2D

onready var open : bool = false
onready var close : bool = true

onready var parent = get_parent()
onready var anim = get_node("AnimationPlayer")
onready var poly = get_node("Polygon2D")

onready var in_1 : bool = false
onready var in_2 : bool = false

func _ready():
	poly.position = get_child(0).position
	poly.rotation = get_child(0).rotation
	poly.polygon = [Vector2(-get_child(0).shape.extents.x,-get_child(0).shape.extents.y),Vector2(get_child(0).shape.extents.x,-get_child(0).shape.extents.y),Vector2(get_child(0).shape.extents.x,get_child(0).shape.extents.y),Vector2(-get_child(0).shape.extents.x,get_child(0).shape.extents.y)]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if parent.triger && close && !anim.is_playing():
		anim.play("open")
		close = false
		open = true
	if parent.triger == false && open:
		anim.play_backwards("open")
		close = true
		open = false
	if in_1 && in_2:
		PlayerVars.player_must_die = true
		in_1 = false
		in_2 = false



func _on_crashing_body_entered(body):
	if body.name == "PlayerRigidBody":
		in_1 = true

func _on_crashing2_body_entered(body):
	if body.name == "PlayerRigidBody":
		in_2 = true

func _on_crashing2_body_exited(body):
	if body.name == "PlayerRigidBody":
		in_2 = false

func _on_crashing_body_exited(body):
	if body.name == "PlayerRigidBody":
		in_1 = false

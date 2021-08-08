extends Node2D

onready var btn = get_node("PhysicBTN2D")
onready var lezer = get_node("LezerRay")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if btn.triger == false:
		lezer.visible = false
		lezer.set_collision_mask_bit(6, false)
		lezer.set_collision_mask_bit(1, false)
	else:
		lezer.visible = true
		lezer.set_collision_mask_bit(6, true)
		lezer.set_collision_mask_bit(1, true)


extends RigidBody2D


onready var par = get_parent()

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if par.triger:
		modulate.a = 1
	else:
		modulate.a = 0.5
	pass

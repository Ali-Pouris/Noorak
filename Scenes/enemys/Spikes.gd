tool
extends StaticBody2D

onready var Coll = get_node("CollisionShape2D")
onready var Spr = get_node("Sprite")
export var Width = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Spr.set_region_rect(Rect2(0,0,Width * 4,4))
	#Width = Spr.get_region_rect().size.x
	Coll.get_shape().set_extents(Vector2(((Width * 4) / 2) - 1 ,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Spr.set_region_rect(Rect2(0,0,Width * 4,4))
	pass

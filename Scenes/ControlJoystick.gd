extends Control

onready var joystick = get_node("joystick")

onready var extra_btn_lift = preload("res://Scenes/Interface_scenes/Extra_RL_lift.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerVars.touch_btn_layout_flip_h:
		if PlayerVars.touch_btn_layout_extra_btn:
			var extra_btn = extra_btn_lift.instance()
			joystick.set_position(Vector2(45,-21))
			extra_btn.set_position(Vector2(45-3.2,15+3.2))
			extra_btn.set_scale(Vector2(-1,1))
			extra_btn.set_action("left_lift")
			add_child(extra_btn)
		else:
			joystick.set_position(Vector2(45,20))
		
		self.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_LEFT,Control.PRESET_MODE_KEEP_SIZE)
	else:
		if PlayerVars.touch_btn_layout_extra_btn:
			var extra_btn = extra_btn_lift.instance()
			joystick.set_position(Vector2(45,-21))
			extra_btn.set_position(Vector2(44+3.2,15+3.2))
			extra_btn.set_scale(Vector2(1,1))
			extra_btn.set_action("right_lift")
			add_child(extra_btn)
		else:
			joystick.set_position(Vector2(45,20))
		
		self.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT,Control.PRESET_MODE_KEEP_SIZE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

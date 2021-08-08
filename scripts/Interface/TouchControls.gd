extends Control

onready var control = get_node("Control2")


# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerVars.touch_btn_layout_flip_h:
		control.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT,Control.PRESET_MODE_KEEP_SIZE)
	else:
		control.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_LEFT,Control.PRESET_MODE_KEEP_SIZE)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

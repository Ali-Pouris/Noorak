extends CanvasLayer

export var look_for_slider : bool = false
onready var brightness_slider = get_node_or_null("../Menu/SettingsContainer/Buttons/VBoxContainer/BSlider")
onready var shadow_slider = get_node_or_null("../Menu/CustomizeContainer/Buttons/VBoxContainer/ShadowSlider")

# Called when the node enters the scene tree for the first time.
func _ready():
	if !look_for_slider:
		$shadow.modulate.a = PlayerVars.fg_shader_alpha
	else:
		yield(get_tree().create_timer(0.1),"timeout")
		$shadow.modulate.a = PlayerVars.fg_shader_alpha


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if look_for_slider:
		if brightness_slider.visible or shadow_slider.visible:
			$shadow.modulate.a = PlayerVars.fg_shader_alpha
	pass

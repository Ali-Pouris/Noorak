extends Node2D

onready var brightness_slider = get_node("../Menu/SettingsContainer/Buttons/VBoxContainer/BSlider")
onready var customize_bg = get_node("../Menu/CustomizeContainer/CustomizeBGContainer")
onready var reset_btn = get_node("../Menu/CustomizeContainer/Buttons/VBoxContainer/Reset")

func _ready():
	visible = true
	yield(get_tree().create_timer(0.1),"timeout")
	for child in get_children():
		if child.is_in_group("bg_back"):
			child.color = PlayerVars.bg_color_back
		if child.is_in_group("bg_mid"):
			child.color = PlayerVars.bg_color_mid
		if child.is_in_group("bg_front"):
			child.color = PlayerVars.bg_color_front
		if child.is_in_group("bg_light"):
			child.color = PlayerVars.bg_color_light

func _process(_delta):
	if brightness_slider.visible or customize_bg.visible or reset_btn.visible:
		for child in get_children():
			if child.is_in_group("bg_back"):
				child.color = PlayerVars.bg_color_back
			if child.is_in_group("bg_mid"):
				child.color = PlayerVars.bg_color_mid
			if child.is_in_group("bg_front"):
				child.color = PlayerVars.bg_color_front
			if child.is_in_group("bg_light"):
				child.color = PlayerVars.bg_color_light
	

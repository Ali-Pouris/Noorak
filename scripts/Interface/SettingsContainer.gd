extends Control

onready var cb_music = get_node("Buttons/VBoxContainer/CheckBoxMusic")
onready var cb_sfx = get_node("Buttons/VBoxContainer/CheckBoxSFX")
onready var camera = get_node("../../AnimationPlayer")

onready var cb_flip = get_node("Buttons/VBoxContainer/CheckBoxFlipH")
onready var cb_extra_btn = get_node("Buttons/VBoxContainer/CheckBoxExtraBTN")

onready var joystick = get_node("Game_HUD/Control")
onready var joystick_image = get_node("Game_HUD/Control/joystick")
onready var twobtns = get_node("Game_HUD/TouchControls/Control2")
onready var extrabtn = get_node("Game_HUD/Control/Extra_RL_lift")

onready var b_slider = get_node("Buttons/VBoxContainer/BSlider")
onready var A_shadow_slider = get_node("Buttons/VBoxContainer/ASlider")

# Called when the node enters the scene tree for the first time.
func _ready():
	cb_music.set_pressed(PlayerVars.music)
	cb_sfx.set_pressed(PlayerVars.sfx)
	
	cb_extra_btn.set_pressed(PlayerVars.touch_btn_layout_extra_btn)
	cb_flip.set_pressed(PlayerVars.touch_btn_layout_flip_h)
	
	get_node("Game_HUD").visible = false
	
	b_slider.set_value(PlayerVars.bg_brightness)
	A_shadow_slider.set_value(PlayerVars.fg_shader_alpha)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if b_slider.visible:
		PlayerVars.bg_color_back = Color.from_hsv(0,0,b_slider.get_value() - 0.2)
		PlayerVars.bg_color_mid = Color.from_hsv(0,0,b_slider.get_value() - 0.26)
		PlayerVars.bg_color_front = Color.from_hsv(0,0,b_slider.get_value() - 0.3)
		PlayerVars.bg_color_light = Color.from_hsv(0,0,1,PlayerVars.map(b_slider.get_value(),0.3,0.7,0.05,0.15))
		PlayerVars.fg_shader_alpha = A_shadow_slider.get_value()
#	print(PlayerVars.music)
#	print(PlayerVars.sfx)


func _on_CheckBoxMusic_toggled(button_pressed):
	PlayerVars.music = cb_music.pressed
	if PlayerVars.music:
		MusicControler.play_menu_music()
	else:
		MusicControler.stop_playing()


func _on_CheckBoxSFX_toggled(button_pressed):
	PlayerVars.sfx = cb_sfx.pressed


func _on_BackToMenu_pressed():
	camera.play("SettingsToMenu")


func _on_layoutbtn_pressed():
	get_node("Buttons/VBoxContainer/BackToMenu").visible = false
	get_node("Buttons/VBoxContainer/HSeparator").visible = false
	get_node("Buttons/VBoxContainer/CheckBoxMusic").visible = false
	get_node("Buttons/VBoxContainer/HSeparator2").visible = false
	get_node("Buttons/VBoxContainer/CheckBoxSFX").visible = false
	get_node("Buttons/VBoxContainer/HSeparator3").visible = false
	get_node("Buttons/VBoxContainer/layoutbtn").visible = false
	get_node("Buttons/VBoxContainer/BrightnessBTN").visible = false
	
	get_node("Buttons/VBoxContainer/HSeparator4").visible = true
	get_node("Buttons/VBoxContainer/HSeparator5").visible = true
	get_node("Buttons/VBoxContainer/Backfromlayout").visible = true
	get_node("Buttons/VBoxContainer/CheckBoxExtraBTN").visible = true
	get_node("Buttons/VBoxContainer/CheckBoxFlipH").visible = true
	get_node("Game_HUD").visible = true
	cb_extra_btn.set_pressed(PlayerVars.touch_btn_layout_extra_btn)
	cb_flip.set_pressed(PlayerVars.touch_btn_layout_flip_h)


func _on_Backfromlayout_pressed():
	var data = SaveLoad.load_the_game()
	if data != null:
		SaveLoad.data["continue_level"] = data["continue_level"]
		SaveLoad.data["levels_unlocked"] = data["levels_unlocked"]
		
		SaveLoad.data["g_particles_color"] = data["spot_color"]
		SaveLoad.data["spot_color"] = data["spot_color"]
		SaveLoad.data["t_particles_color"] = data["t_particles_color"]
		SaveLoad.data["light_color"] = data["light_color"]
#		"bg_color_back" : PlayerVars.bg_color_back,
#		"bg_color_mid" : PlayerVars.bg_color_mid,
#		"bg_color_front" : PlayerVars.bg_color_front,
#		"bg_color_light" : PlayerVars.bg_color_light,
#		"fg_shader_alpha" : 0.862,
	SaveLoad.data["touch_btn_layout_extra_btn"] = PlayerVars.touch_btn_layout_extra_btn
	SaveLoad.data["touch_btn_layout_flip_h"] = PlayerVars.touch_btn_layout_flip_h
	SaveLoad.data["brightness"] = b_slider.get_value()
	SaveLoad.data["bg_color_back"] = PlayerVars.bg_color_back
	SaveLoad.data["bg_color_mid"] = PlayerVars.bg_color_mid
	SaveLoad.data["bg_color_front"] = PlayerVars.bg_color_front
	SaveLoad.data["bg_color_light"] = PlayerVars.bg_color_light
	SaveLoad.data["fg_shader_alpha"] = PlayerVars.fg_shader_alpha
	PlayerVars.bg_brightness = b_slider.get_value()
	SaveLoad.save_the_game()
	
	get_node("Buttons/VBoxContainer/BackToMenu").visible = true
	get_node("Buttons/VBoxContainer/HSeparator").visible = true
	get_node("Buttons/VBoxContainer/CheckBoxMusic").visible = true
	get_node("Buttons/VBoxContainer/HSeparator2").visible = true
	get_node("Buttons/VBoxContainer/CheckBoxSFX").visible = true
	get_node("Buttons/VBoxContainer/HSeparator3").visible = true
	get_node("Buttons/VBoxContainer/layoutbtn").visible = true
	get_node("Buttons/VBoxContainer/BrightnessBTN").visible = true
	
	get_node("Buttons/VBoxContainer/CheckBoxExtraBTN").visible = false
	get_node("Buttons/VBoxContainer/CheckBoxFlipH").visible = false
	get_node("Buttons/VBoxContainer/Backfromlayout").visible = false
	get_node("Buttons/VBoxContainer/HSeparator4").visible = false
	get_node("Buttons/VBoxContainer/HSeparator5").visible = false
	get_node("Buttons/VBoxContainer/DefaultBrightnessBTN").visible = false
	get_node("Buttons/VBoxContainer/HSeparator6").visible = false
	get_node("Buttons/VBoxContainer/HSeparator7").visible = false
	get_node("Buttons/VBoxContainer/HSeparator8").visible = false
	get_node("Buttons/VBoxContainer/Label").visible = false
	get_node("Buttons/VBoxContainer/Label2").visible = false
	b_slider.visible = false
	A_shadow_slider.visible = false
	get_node("Game_HUD").visible = false


func _on_CheckBoxExtraBTN_toggled(button_pressed):
	PlayerVars.touch_btn_layout_extra_btn = cb_extra_btn.pressed
	if cb_extra_btn.pressed:
		joystick_image.set_position(Vector2(45,-21))
		extrabtn.visible = true
	else:
		joystick_image.set_position(Vector2(45,20))
		extrabtn.visible = false


func _on_CheckBoxFlipH_toggled(button_pressed):
	PlayerVars.touch_btn_layout_flip_h = cb_flip.pressed
	if cb_flip.pressed:
#		extrabtn.set_position(Vector2(27+38.5,15))
		extrabtn.set_position(Vector2(45-3.2,15+3.2))
		extrabtn.set_scale(Vector2(-1,1))
		joystick.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_LEFT,Control.PRESET_MODE_KEEP_SIZE)
		twobtns.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT,Control.PRESET_MODE_KEEP_SIZE)
	else:
		extrabtn.set_position(Vector2(44+3.2,15+3.2))
		extrabtn.set_scale(Vector2(1,1))
		joystick.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_RIGHT,Control.PRESET_MODE_KEEP_SIZE)
		twobtns.set_anchors_and_margins_preset(Control.PRESET_BOTTOM_LEFT,Control.PRESET_MODE_KEEP_SIZE)


func _on_BrightnessBTN_pressed():
	get_node("Buttons/VBoxContainer/BackToMenu").visible = false
	get_node("Buttons/VBoxContainer/HSeparator").visible = false
	get_node("Buttons/VBoxContainer/CheckBoxMusic").visible = false
	get_node("Buttons/VBoxContainer/HSeparator2").visible = false
	get_node("Buttons/VBoxContainer/CheckBoxSFX").visible = false
	get_node("Buttons/VBoxContainer/HSeparator3").visible = false
	get_node("Buttons/VBoxContainer/layoutbtn").visible = false
	get_node("Buttons/VBoxContainer/BrightnessBTN").visible = false
	
	get_node("Buttons/VBoxContainer/Backfromlayout").visible = true
	get_node("Buttons/VBoxContainer/DefaultBrightnessBTN").visible = true
	get_node("Buttons/VBoxContainer/HSeparator6").visible = true
	get_node("Buttons/VBoxContainer/HSeparator7").visible = true
	get_node("Buttons/VBoxContainer/HSeparator8").visible = true
	get_node("Buttons/VBoxContainer/Label").visible = true
	get_node("Buttons/VBoxContainer/Label2").visible = true
	b_slider.visible = true
	A_shadow_slider.visible = true



func _on_DefaultBrightnessBTN_pressed():
	b_slider.set_value(0.6)
	A_shadow_slider.set_value(0.862)

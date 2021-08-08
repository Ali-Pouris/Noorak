extends Control

onready var h_slide = get_node("Buttons/VBoxContainer/VBoxContainer/HBoxContainer/Control/HSlider")
onready var s_slide = get_node("Buttons/VBoxContainer/VBoxContainer/HBoxContainer2/Control/SSlider")
onready var l_slide = get_node("Buttons/VBoxContainer/VBoxContainer/HBoxContainer3/Control/LSlider")
onready var a_slide = get_node("Buttons/VBoxContainer/VBoxContainer/HBoxContainer4/Control/ASlider")
onready var a_slide_label = get_node("Buttons/VBoxContainer/VBoxContainer/HBoxContainer4/Control/Label")
onready var slider_touched : bool = false

onready var checkbox_back = get_node("checkboxes/HBoxContainer/CheckBoxBack")
onready var checkbox_mid = get_node("checkboxes/HBoxContainer/CheckBoxMiddle")
onready var checkbox_front = get_node("checkboxes/HBoxContainer/CheckBoxFront")
onready var checkbox_light = get_node("checkboxes/HBoxContainer/CheckBoxLight")


#onready var camera = get_node("../../AnimationPlayer")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	s_slide.set_value(1.0)
	l_slide.set_value(1.0)
	a_slide.set_value(1.0)
	
	checkbox_back.pressed = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var color_holder = Color.from_hsv(h_slide.get_value(),s_slide.get_value(),l_slide.get_value())
	var color_holder_a = Color.from_hsv(h_slide.get_value(),s_slide.get_value(),l_slide.get_value(),a_slide.get_value())
	
	if checkbox_light.pressed:
		a_slide.visible = true
		a_slide_label.visible = true
	else:
		a_slide.visible = false
		a_slide_label.visible = false
	
	if slider_touched:
		if checkbox_back.pressed == true && checkbox_mid.pressed == true && checkbox_front.pressed == true && checkbox_light.pressed == true:
			PlayerVars.bg_color_back = color_holder
			PlayerVars.bg_color_mid = color_holder
			PlayerVars.bg_color_front = color_holder
			PlayerVars.bg_color_light = color_holder_a
		else:
			if checkbox_mid.pressed:
				PlayerVars.bg_color_mid = color_holder
				
			if checkbox_back.pressed:
				PlayerVars.bg_color_back = color_holder
				
			if checkbox_front.pressed:
				PlayerVars.bg_color_front = color_holder
			
			if checkbox_light.pressed:
				PlayerVars.bg_color_light = color_holder_a
			
	
	pass


func _on_TouchScreenButton_pressed():
	slider_touched = true

#
#func _on_RandomiseColor_pressed():
#	slider_touched = false
#	var c = Color(rand_range(0.0,1.0), rand_range(0.0,1.0), rand_range(0.0,1.0))
#	g_particles.modulate = c
#	t_particles.modulate = Color(rand_range(0.0,1.0), rand_range(0.0,1.0), rand_range(0.0,1.0))
#	spot.modulate = c
#	light.modulate = Color(rand_range(0.0,1.0), rand_range(0.0,1.0), rand_range(0.0,1.0))
#	light.modulate.a = rand_range(0.5,1.0)


#
#func _on_BackToMenu_pressed():
#	camera.play("CustomizeToMenu")
##	PlayerVars.is_colors_changed = true
#	PlayerVars.g_particles_color = spot.modulate
#	PlayerVars.t_particles_color = t_particles.modulate
#	PlayerVars.spot_color = spot.modulate
#	PlayerVars.light_color = light.modulate
#	var data = SaveLoad.load_the_game()
#	if data != null:
#		SaveLoad.data["continue_level"] = data["continue_level"]
#		SaveLoad.data["levels_unlocked"] = data["levels_unlocked"]
#	SaveLoad.data["g_particles_color"] = spot.modulate
#	SaveLoad.data["t_particles_color"] = t_particles.modulate
#	SaveLoad.data["spot_color"] = spot.modulate
#	SaveLoad.data["light_color"] = light.modulate
#	SaveLoad.data["touch_btn_layout_extra_btn"] = PlayerVars.touch_btn_layout_extra_btn
#	SaveLoad.data["touch_btn_layout_flip_h"] = PlayerVars.touch_btn_layout_flip_h
#	SaveLoad.save_the_game()




#func _on_Themes_pressed():
#	get_node("Buttons/VBoxContainer/BackToMenu").visible = false
#	get_node("Buttons/VBoxContainer/RandomiseColor").visible = false
#	get_node("Buttons/VBoxContainer/Themes").visible = false
#	get_node("Buttons/VBoxContainer/VBoxContainer").visible = false
#	get_node("checkboxes").visible = false
#
#
#	get_node("Buttons/VBoxContainer/Back").visible = true
#	get_node("Buttons/VBoxContainer/t2").visible = true
#	get_node("Buttons/VBoxContainer/t3").visible = true
#	get_node("Buttons/VBoxContainer/t4").visible = true
#	get_node("Buttons/VBoxContainer/t5").visible = true
#	get_node("Buttons/VBoxContainer/t6").visible = true
#	get_node("Buttons/VBoxContainer/t7").visible = true
#
#	pass # Replace with function body.


#func _on_Back_pressed():
#	get_node("Buttons/VBoxContainer/Back").visible = false
#	get_node("Buttons/VBoxContainer/t2").visible = false
#	get_node("Buttons/VBoxContainer/t3").visible = false
#	get_node("Buttons/VBoxContainer/t4").visible = false
#	get_node("Buttons/VBoxContainer/t5").visible = false
#	get_node("Buttons/VBoxContainer/t6").visible = false
#	get_node("Buttons/VBoxContainer/t7").visible = false
#
#	get_node("Buttons/VBoxContainer/BackToMenu").visible = true
#	get_node("Buttons/VBoxContainer/RandomiseColor").visible = true
#	get_node("Buttons/VBoxContainer/Themes").visible = true
#	get_node("Buttons/VBoxContainer/VBoxContainer").visible = true
#	get_node("checkboxes").visible = true
#
#
#
#func _on_Themes2_pressed():
#	print("g_particles: " + str(g_particles.modulate))
#	print("t_particles: " + str(t_particles.modulate))
#	print("spot: " + str(spot.modulate))
#	print("light: " + str(light.modulate))
#	pass # Replace with function body.
#
##==Deafault Color
#func _on_t2_pressed():
#	slider_touched = false
#	g_particles.modulate = default_color
#	t_particles.modulate = default_color
#	spot.modulate = default_color
#	light.modulate = default_color
#	light.modulate.a = PlayerVars.light_color_alpha
#
##++theme zomorrod
#func _on_t3_pressed():
#	slider_touched = false
#	g_particles.modulate = Color(0,1,0.442,1)
#	t_particles.modulate = Color(0.963,0.929969,0.632691,1)
#	spot.modulate = Color(0,1,0.442,1)
#	light.modulate = Color(0,1,0.76,0.7)
#	pass # Replace with function body.
#
##==theme Dracula
#func _on_t4_pressed():
#	slider_touched = false
#	g_particles.modulate = Color(0,0,0,1)
#	t_particles.modulate = Color(1,0,0,0.813)
#	spot.modulate = Color(0,0,0,1)
#	light.modulate = Color(0,0,0,0)
#	pass # Replace with function body.
#
##===Cloud & Sky
#func _on_t5_pressed():
#	slider_touched = false
#	g_particles.modulate = Color(1,1,1,1)
#	t_particles.modulate = Color(0.169,0.655966,1,1)
#	spot.modulate = Color(1,1,1,1)
#	light.modulate = Color(1,0,0,0)
#	pass # Replace with function body.
#
##===YB
#func _on_t6_pressed():
#	slider_touched = false
#	g_particles.modulate = Color(1,0.93,0,1)
#	t_particles.modulate = Color(1,0.93,0,1)
#	spot.modulate = Color(1,0.93,0,1)
#	light.modulate = Color(0.233,0.802114,1,0.85)
#	pass # Replace with function body.
#
##===Invisible
#func _on_t7_pressed():
#	slider_touched = false
#	g_particles.modulate = Color(0,0,0,0)
#	t_particles.modulate = Color(0,0,0,0)
#	spot.modulate = Color(0,0,0,0)
#	light.modulate = Color(0,0,0,0)
#	pass # Replace with function body.



func _on_Themes_pressed():
	get_node("Buttons/VBoxContainer/BackFromBG").visible = false
	get_node("Buttons/VBoxContainer/RandomiseColor").visible = false
	get_node("Buttons/VBoxContainer/Themes").visible = false
	get_node("Buttons/VBoxContainer/VBoxContainer").visible = false
	get_node("checkboxes").visible = false
#
#
	get_node("Buttons/VBoxContainer/Back").visible = true
	get_node("Buttons/VBoxContainer/t2").visible = true
#	get_node("Buttons/VBoxContainer/t3").visible = true
#	get_node("Buttons/VBoxContainer/t4").visible = true
#	get_node("Buttons/VBoxContainer/t5").visible = true
#	get_node("Buttons/VBoxContainer/t6").visible = true
#	get_node("Buttons/VBoxContainer/t7").visible = true


func _on_t2_pressed():
	slider_touched = false
	PlayerVars.bg_brightness = 0.6

	PlayerVars.bg_color_back = Color.from_hsv(0,0,PlayerVars.bg_brightness - 0.2)
	PlayerVars.bg_color_mid = Color.from_hsv(0,0,PlayerVars.bg_brightness - 0.26)
	PlayerVars.bg_color_front = Color.from_hsv(0,0,PlayerVars.bg_brightness - 0.3)
	PlayerVars.bg_color_light = Color.from_hsv(0,0,1,PlayerVars.map(PlayerVars.bg_brightness,0.3,0.7,0.05,0.15))


func _on_Back_pressed():
	get_node("Buttons/VBoxContainer/BackFromBG").visible = true
	get_node("Buttons/VBoxContainer/RandomiseColor").visible = true
	get_node("Buttons/VBoxContainer/Themes").visible = true
	get_node("Buttons/VBoxContainer/VBoxContainer").visible = true
	get_node("checkboxes").visible = true
#
#
	get_node("Buttons/VBoxContainer/Back").visible = false
	get_node("Buttons/VBoxContainer/t2").visible = false
#	get_node("Buttons/VBoxContainer/t3").visible = false
#	get_node("Buttons/VBoxContainer/t4").visible = false
#	get_node("Buttons/VBoxContainer/t5").visible = false
#	get_node("Buttons/VBoxContainer/t6").visible = false
#	get_node("Buttons/VBoxContainer/t7").visible = false


func _on_RandomiseColor_pressed():
	slider_touched = false
	var rc = rand_range(0.0,1.0)
	var rc2 = rand_range(0.3,1.0)
#	PlayerVars.bg_brightness = 0.6
	PlayerVars.bg_brightness = rand_range(0.4,0.7)

	PlayerVars.bg_color_back = Color.from_hsv(rc,rc2,PlayerVars.bg_brightness - 0.2)
	PlayerVars.bg_color_mid = Color.from_hsv(rc,rc2,PlayerVars.bg_brightness - 0.26)
	PlayerVars.bg_color_front = Color.from_hsv(rc,rc2,PlayerVars.bg_brightness - 0.3)
	PlayerVars.bg_color_light = Color.from_hsv(rc,rc2,1,PlayerVars.map(PlayerVars.bg_brightness,0.3,0.7,0.05,0.15))

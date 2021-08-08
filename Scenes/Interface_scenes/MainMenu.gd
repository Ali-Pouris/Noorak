extends Control

onready var camera = get_node("AnimationPlayer")
onready var anim_levels_panel = get_node("AnimationPlayerLevelsPanel")
onready var anim_menu_panel = get_node("AnimationPlayerMenuPanel")

onready var g_particles = get_node("player/PlayerRigidBody/GlowingParticles")
onready var t_particles = get_node("player/PlayerRigidBody/TrailParticles")
onready var spot = get_node("player/PlayerRigidBody/spot")
onready var light = get_node("player/PlayerRigidBody/light")

# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerVars.music:
		MusicControler.play_menu_music()
	#customize colors
	var data = SaveLoad.load_the_game()
	if data != null:
		g_particles.modulate = data["spot_color"]
		t_particles.modulate = data["t_particles_color"]
		spot.modulate = data["spot_color"]
		light.modulate = data["light_color"]
		PlayerVars.touch_btn_layout_extra_btn = data["touch_btn_layout_extra_btn"]
		PlayerVars.touch_btn_layout_flip_h = data["touch_btn_layout_flip_h"]
		SaveLoad.data["continue_level"] = data["continue_level"]
		SaveLoad.data["levels_unlocked"] = data["levels_unlocked"]
		
		SaveLoad.data["touch_btn_layout_extra_btn"] = data["touch_btn_layout_extra_btn"]
		SaveLoad.data["touch_btn_layout_flip_h"] = data["touch_btn_layout_flip_h"]
		
		SaveLoad.data["spot_color"] = data["spot_color"]
		SaveLoad.data["g_particles_color"] = data["spot_color"]
		SaveLoad.data["t_particles_color"] = data["t_particles_color"]
		SaveLoad.data["light_color"] = data["light_color"]
		
		SaveLoad.data["brightness"] = data["brightness"]
		SaveLoad.data["bg_color_back"] = data["bg_color_back"]
		SaveLoad.data["bg_color_mid"] = data["bg_color_mid"]
		SaveLoad.data["bg_color_front"] = data["bg_color_front"]
		SaveLoad.data["bg_color_light"] = data["bg_color_light"]
		SaveLoad.data["fg_shader_alpha"] = data["fg_shader_alpha"]
	else:
		g_particles.modulate = PlayerVars.spot_color
		t_particles.modulate = PlayerVars.t_particles_color
		spot.modulate = PlayerVars.spot_color
		light.modulate = PlayerVars.light_color
		light.modulate.a = PlayerVars.light_color_alpha
	
	PlayerVars.g_particles_color = spot.modulate
	PlayerVars.t_particles_color = t_particles.modulate
	PlayerVars.spot_color = spot.modulate
	PlayerVars.light_color = light.modulate
	
	PlayerVars.bg_brightness = SaveLoad.data["brightness"]
	PlayerVars.bg_color_back = SaveLoad.data["bg_color_back"]
	PlayerVars.bg_color_mid = SaveLoad.data["bg_color_mid"]
	PlayerVars.bg_color_front = SaveLoad.data["bg_color_front"]
	PlayerVars.bg_color_light = SaveLoad.data["bg_color_light"]
	PlayerVars.fg_shader_alpha = SaveLoad.data["fg_shader_alpha"]
	
	#play the intro only once
	if PlayerVars.is_first_time_boot:
		PlayerVars.is_first_time_boot = false
		camera.play("intro")
	else:
		camera.play("no_intro")
		anim_menu_panel.play("fade_in")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	PlayerVars.reset_checkpoints()
	var data = SaveLoad.load_the_game()
	if data != null:
		#This loop find the continue_level file and change the scene to that level
		for n in range(data["levels_unlocked"]):
			if data["levels_unlocked"] == n+1:
				var level_file := "res://Scenes/Levels/level_" + str(n+1) + ".tscn"
				if get_tree().change_scene(level_file) != OK:
					print ("An unexpected error occured when trying to switch to the " + "level_" + str(n+1) +  " scene")
	else:
		#First Run Level
		if get_tree().change_scene("res://Scenes/Levels/level_" + str(1) + ".tscn") != OK:
			print ("An unexpected error occured when trying to switch to the " + "level_1" +  " scene")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Levels_pressed():
	camera.play("MenuToLevels")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/level_1.tscn")


func _on_BackToMenu_pressed():
	camera.play("LevelsToMenu")



func _on_Customize_pressed():
	camera.play("MenuToCustomize")


func _on_Settings_pressed():
	camera.play("MenuToSettings")


func _on_About_Me_pressed():
	camera.play("MenuToAboutme")


func _on_AboutToMenu_pressed():
	camera.play("AboutmeToMenu")

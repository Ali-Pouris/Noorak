extends StaticBody2D

onready var animation = $"AnimationPlayer"
export var next_scene : PackedScene
export var next_level : int = 1



func _on_body_entered(body):
	if body.get_parent().name == "player":
		PlayerVars.reset_checkpoints()
		SaveLoad.data["continue_level"] = next_level
		var d = SaveLoad.load_the_game()
		if d != null:
			if d["levels_unlocked"] <= next_level:
				SaveLoad.data["levels_unlocked"] = next_level
		else:
			#first time level 2 unlocked
			SaveLoad.data["levels_unlocked"] = 2
		
		SaveLoad.data["g_particles_color"] = PlayerVars.spot_color
		SaveLoad.data["t_particles_color"] = PlayerVars.t_particles_color
		SaveLoad.data["spot_color"] = PlayerVars.spot_color
		SaveLoad.data["light_color"] = PlayerVars.light_color
		
		SaveLoad.data["touch_btn_layout_extra_btn"] = PlayerVars.touch_btn_layout_extra_btn
		SaveLoad.data["touch_btn_layout_flip_h"] = PlayerVars.touch_btn_layout_flip_h
		
		SaveLoad.data["brightness"] = PlayerVars.bg_brightness
		SaveLoad.data["bg_color_back"] = PlayerVars.bg_color_back
		SaveLoad.data["bg_color_mid"] = PlayerVars.bg_color_mid
		SaveLoad.data["bg_color_front"] = PlayerVars.bg_color_front
		SaveLoad.data["bg_color_light"] = PlayerVars.bg_color_light
		SaveLoad.data["fg_shader_alpha"] = PlayerVars.fg_shader_alpha
		
		SaveLoad.save_the_game()
		body.player_flash(body)
		teleport()

func teleport():
	animation.play("fade_in")
	yield(animation,"animation_finished")
	if get_tree().change_scene_to(next_scene) != OK:
		print ("exit_portal: An unexpected error occured when trying to switch to the next scene")


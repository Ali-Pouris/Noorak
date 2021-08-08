extends Node

const SAVE_DIR = "user://NOOR_GAME_SAVES/"

var save_path = SAVE_DIR + "save.dat"

var data = {
	"continue_level" : 1,
	"levels_unlocked" : 1,
	"touch_btn_layout_extra_btn" : false,
	"touch_btn_layout_flip_h" : false,
	"brightness" : PlayerVars.bg_brightness,
	"bg_color_back" : PlayerVars.bg_color_back,
	"bg_color_mid" : PlayerVars.bg_color_mid,
	"bg_color_front" : PlayerVars.bg_color_front,
	"bg_color_light" : PlayerVars.bg_color_light,
	"fg_shader_alpha" : PlayerVars.fg_shader_alpha,
	"g_particles_color" : PlayerVars.g_particles_color,
	"t_particles_color" : PlayerVars.t_particles_color,
	"spot_color" : PlayerVars.spot_color,
	"light_color" : PlayerVars.light_color,
	}


func save_the_game():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
		print("saving ok")
	print("saving")

func load_the_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			print("loading ok")
			return player_data
	print("loading")

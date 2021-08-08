extends Control

func _on_start_btn_released():
	PlayerVars.reset_checkpoints()
	var data = SaveLoad.load_the_game()
	if data != null:
		#This loop find the continue_level file and change the scene to that level
		for n in range(data["continue_level"]):
			if data["continue_level"] == n+1:
				var level_file := "res://Scenes/Levels/level_" + str(n+1) + ".tscn"
				if get_tree().change_scene(level_file) != OK:
					print ("An unexpected error occured when trying to switch to the " + "level_" + str(n+1) +  " scene")
	else:
		#First Run Level
		if get_tree().change_scene("res://Scenes/Levels/level_" + str(1) + ".tscn") != OK:
			print ("An unexpected error occured when trying to switch to the " + "level_1" +  " scene")

func _on_exit_btn_released():
	get_tree().quit()


func _on_newgame_btn_released():
	PlayerVars.reset_checkpoints()
	SaveLoad.data["continue_level"] = 1
	SaveLoad.save_the_game()
	print("New Game!")


func _on_newgame_btn2_released():
	get_tree().change_scene("res://Scenes/Interface_scenes/MainMenu.tscn")

extends Control

onready var camera = get_node("../../AnimationPlayer")

onready var all_the_levels = get_node("VBoxContainer/VBoxContainer")

export var unlock_level : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if unlock_level == 0:
		var count = 1
		var data = SaveLoad.load_the_game()
		if data != null:
			for i in all_the_levels.get_children():
				for j in i.get_children():
					if count <= data["levels_unlocked"]:
						j.text = str(count)
						j.connect("pressed", self, "go_to_level",[count])
					else:
						j.text = "*"
					count += 1
		else:
			var n = 1
			for i in all_the_levels.get_children():
				for j in i.get_children():
					if n == 1:
						j.text = "1"
						j.connect("pressed", self, "go_to_level",[1])
					else:
						j.text = "*"
					n += 1
	else:
		var x = 1
		for i in all_the_levels.get_children():
			for j in i.get_children():
				if x <= unlock_level:
					j.text = str(x)
					j.connect("pressed", self, "go_to_level",[x])
				else:
					j.text = "*"
				x += 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func go_to_level(level):
	get_tree().change_scene("res://Scenes/Levels/level_" + str(level) + ".tscn")


func _on_BackToMenu_pressed():
	camera.play("LevelsToMenu")

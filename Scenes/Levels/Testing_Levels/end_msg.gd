extends Control

func _ready():
	yield(get_tree().create_timer(6),"timeout")
	get_tree().change_scene("res://Scenes/Interface_scenes/MainMenu.tscn")

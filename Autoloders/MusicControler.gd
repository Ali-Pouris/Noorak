extends Node

onready var music = get_node("Music")
onready var empty_city = preload("res://Music/EmptyCity.ogg")


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_menu_music():
	if PlayerVars.music:
		music.set_stream(empty_city)
		music.play()

func stop_playing():
	music.stop()

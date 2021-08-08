extends AudioStreamPlayer2D

export var sound_path_1 = ""
export var sound_path_2 = ""
export var sound_path_3 = ""
export var sound_path_4 = ""
export var sound_path_5 = ""

var sound_file_1
var sound_file_2
var sound_file_3
var sound_file_4
var sound_file_5

var sound_count : int

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	if sound_path_1 != "":
		sound_file_1 = load(sound_path_1)
		sound_count = 1
	if sound_path_2 != "":
		sound_file_2 = load(sound_path_2)
		sound_count = 2
	if sound_path_3 != "":
		sound_file_3 = load(sound_path_3)
		sound_count = 3
	if sound_path_4 != "":
		sound_file_4 = load(sound_path_4)
		sound_count = 4
	if sound_path_5 != "":
		sound_file_5 = load(sound_path_5)
		sound_count = 5
	
	pass # Replace with function body.

func random_sound():
	var n = randi() % sound_count
	if n == 0:
		stream = sound_file_1
	elif n == 1:
		stream = sound_file_2
	elif n == 2:
		stream = sound_file_3
	elif n == 3:
		stream = sound_file_4
	elif n == 4:
		stream = sound_file_5

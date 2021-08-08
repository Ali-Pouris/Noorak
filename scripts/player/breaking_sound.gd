extends AudioStreamPlayer

onready var break_sound_1 = load("res://Music/sfx/player/noor_dies_1.ogg")
onready var break_sound_2 = load("res://Music/sfx/player/noor_dies_2.ogg")

func _ready():
	randomize()
	var n = randi() % 2
	if n == 0:
		stream = break_sound_1
	else:
		stream = break_sound_2
	pitch_scale = rand_range(0.9,1.1)
	volume_db = 0
#	print("breaking sound is seted")

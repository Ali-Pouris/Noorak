extends AudioStreamPlayer

onready var hit_sound_1 = load("res://Music/sfx/player/glass_hit_1.ogg")
onready var hit_sound_2 = load("res://Music/sfx/player/glass_hit_2.ogg")
onready var hit_sound_3 = load("res://Music/sfx/player/glass_hit_3.ogg")
onready var hit_sound_4 = load("res://Music/sfx/player/glass_hit_4.ogg")


func _ready():
	randomize()


func glass_hit():
	var n = randi() % 4
	if n == 0:
		stream = hit_sound_1
	elif n == 1:
		stream = hit_sound_2
	elif n == 2:
		stream = hit_sound_3
	else:
		stream = hit_sound_4



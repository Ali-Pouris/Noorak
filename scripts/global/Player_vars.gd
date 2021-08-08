extends Node

var player_is_dead : bool
var player_must_die : bool = false

var checkpoint_number : int = 0
var checkpoint_position : Vector2

var is_first_time_boot : bool = true 

#customize Player colors
var is_colors_changed : bool = false
var default_color = Color(255,255,255,1)
var g_particles_color : Color = default_color
var t_particles_color : Color = default_color
var spot_color : Color = default_color
var light_color_alpha = 0.5
var light_color : Color = Color(255,255,255,light_color_alpha)
var invisible_theme : bool = false
var balls_color : Color

#customize BackGround colors
var bg_brightness = 0.6

var bg_color_back = Color.from_hsv(0,0,bg_brightness - 0.2)
var bg_color_mid = Color.from_hsv(0,0,bg_brightness - 0.26)
var bg_color_front = Color.from_hsv(0,0,bg_brightness - 0.3)
var bg_color_light = Color.from_hsv(0,0,1,map(bg_brightness,0.3,0.7,0.05,0.15))

var fg_shader_alpha = 0.862

#==settings
var music : bool = true
var sfx : bool = true

#==touch screen layout
var touch_btn_layout_extra_btn : bool = false
var touch_btn_layout_flip_h : bool = false


func _process(_delta):
	if spot_color.a == 0:
		invisible_theme = true
	else:
		invisible_theme = false


func reset_checkpoints():
	PlayerVars.checkpoint_number = 0

func map(n, start1, stop1, start2, stop2):
	return (n - start1) / (stop1 - start1) * (stop2 - start2) + start2;

func set_loop_mode(stream, loop):
	if stream is AudioStreamOGGVorbis:
		stream.loop = bool(loop)
	else:
		stream.loop_mode = loop

func play_hit_sound(object, sound, time_start, delay = 200, min_volume = -50, max_volume = -10, min_speed = 1, max_speed = 100):
	var time_now = OS.get_ticks_msec()
	var time_elapsed = time_now - time_start
	var speed = abs(object.linear_velocity.length())
	if time_elapsed >= delay:
		if speed > max_speed:
			sound.volume_db = max_volume
		elif speed <= min_speed:
			sound.volume_db = min_volume
		else:
			sound.volume_db = map(speed, min_speed, max_speed, min_volume, max_volume)
		sound.pitch_scale = rand_range(0.9,1.1)
		sound.random_sound()
		sound.play()
#	elif body.get_class() == "RigidBody2D":
#		var other_speed = abs(body.linear_velocity.length())
#		if other_speed > 40:
#			if other_speed > max_speed:
#				sound.volume_db = max_volume
#			elif other_speed <= min_speed:
#				sound.volume_db = min_volume
#			else:
#				sound.volume_db = map(other_speed, min_speed, max_speed, min_volume, max_volume)
#			sound.pitch_scale = rand_range(0.9,1.1)
#			sound.play()

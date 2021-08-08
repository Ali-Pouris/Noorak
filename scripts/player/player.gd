extends RigidBody2D

signal lezer_hiting_player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = $'../Camera2D'
onready var GlowingParticles = $"../GlowingParticles"
onready var SpeedDangerAnim = $"SpeedDanger/AnimationPlayer"
onready var Joystick = get_node("../CanvasLayer/Control/joystick")
onready var CenterPos = get_node("../CenterPos")
onready var ControlJoystick = get_node("../CanvasLayer/Control")
onready var hiting_sound = get_node("../hiting_sound")
onready var breaking_sound = get_node("../breaking_sound")
onready var wind_sound = get_node("../wind_sound")

#=====waves
var balls = preload("res://Scenes/balls.tscn")
var dead_body = preload("res://Scenes/DeadBody.tscn")
var dead_body_flash = preload("res://Scenes/DeadBody_Flash.tscn")

#=====its good to finding angle or speed
var look_direction = Vector2.ZERO

#=====variables for wave action
var can_fire = true
var rate_of_fire = 0.4
var angle_steps : float

var slow_down: float = 0.0

#==========variables for sound control
onready var time_start = 0.0
onready var time_now = 0.0

func play_hit_sound():
	if PlayerVars.sfx:
		time_now = OS.get_ticks_msec()
		var time_elapsed = time_now - time_start
		var speed = abs(self.linear_velocity.length())
		if time_elapsed >= 100:
			if speed > 40:
				hiting_sound.volume_db = -20
			elif speed == 0:
				hiting_sound.volume_db = -50
			else:
				hiting_sound.volume_db = PlayerVars.map(speed, 0, 40, -50, -20)
			hiting_sound.pitch_scale = rand_range(0.8,1.2)
			hiting_sound.glass_hit()
			hiting_sound.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	#=====variables for dead stuuf
	PlayerVars.player_is_dead = false
	#========where player shoud start the game if there is checkpoint activeted
	if PlayerVars.checkpoint_number > 0:
		set_global_position(PlayerVars.checkpoint_position)
	#=======that vector2 is for animation from top to player
	camera.set_position(get_global_position() + Vector2(0,-100))
	#change all the colors
	#==colors testing save
	get_node("../GlowingParticles").modulate = PlayerVars.spot_color
	get_node("TrailParticles").modulate = PlayerVars.t_particles_color
	get_node("spot").modulate = PlayerVars.spot_color
	get_node("light").modulate = PlayerVars.light_color
	PlayerVars.balls_color = PlayerVars.t_particles_color
	if PlayerVars.invisible_theme:
		get_node("SpeedDanger").modulate.a = 0.0
		get_node("../CenterPos").modulate.a = 0.0
	else:
		get_node("SpeedDanger").modulate = PlayerVars.t_particles_color
		get_node("../CenterPos").modulate = PlayerVars.t_particles_color
		get_node("../CenterPos").modulate.a = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("right_lift"):
		apply_impulse(Vector2(0,0), Vector2(2,-3.5) * delta * 60)
	if Input.is_action_pressed("left_lift"):
		apply_impulse(Vector2(0,0), Vector2(-2,-3.5) * delta * 60) 
	#======Speed_danger animation
	if self.get_linear_velocity().length() > 40:
		SpeedDangerAnim.play("speed_danger")
	else:
		SpeedDangerAnim.stop(true)
		SpeedDangerAnim.get_parent().set_scale(Vector2(0,0))
	#======Balls explosive
	WaveLoopAiming()
	WaveLoop()
	WaveLoopJoystickCenter()
	WaveLoopJoystickAngle()
	#======camera zoom and pivot use this dont remove it
	look_direction = Vector2(linear_velocity.x,linear_velocity.y)
	#=======After all moves set the postions========
	if PlayerVars.player_is_dead == false:
		camera.set_position(self.position)
	GlowingParticles.set_position(self.position)
	CenterPos.set_position(self.position)
	#=============player_must_die_no_matter_what!!!====================
	if PlayerVars.player_must_die:
		PlayerVars.player_must_die = false
		player_must_die()
	#==========wind sound=======
	wind_sound()
	if PlayerVars.sfx == false:
		hiting_sound.volume_db = -80
		breaking_sound.volume_db = -80
		wind_sound.volume_db = -80

func wind_sound():
	if PlayerVars.sfx:
		var speed = abs(self.linear_velocity.length())
		if PlayerVars.player_is_dead == false:
			if speed > 180:
				wind_sound.volume_db = -10
			elif speed <= 0:
				wind_sound.volume_db = -80
			else:
				wind_sound.volume_db = PlayerVars.map(speed, 0, 180, -38, -10)
		#		$Wind.pitch_scale = map(speed,0 , 100, 1, 2)
		else:
			wind_sound.volume_db = -80

func WaveLoop():
	if (Input.is_action_pressed("wave") and can_fire == true and PlayerVars.player_is_dead == false):
		can_fire = false
		angle_steps = 0.0
		#I use for to spawn multiple balls at one shot 36 is number_of_balls
		for _b in range(0,36):
			var balls_instance = balls.instance()
			balls_instance.set_position(self.position)
			balls_instance.set_rotation(angle_steps)
			angle_steps += 10
			get_parent().add_child(balls_instance)
		yield(get_tree().create_timer(rate_of_fire),"timeout")
		can_fire = true

func WaveLoopAiming():
	if (Joystick.get_node("joystick_button").where_is_joystick_btn() == 1 and can_fire == true and PlayerVars.player_is_dead == false):
			#print("inside")
			#apply_central_impulse(Vector2(linear_velocity * lerp(-0.02, -1, slow_down)))
			CenterPos.set_rotation_degrees(Joystick.get_node("joystick_button").get_angle() + 180)
			CenterPos.get_node("shot_angle").visible = false
			#OuterPos.get_node("LightAim").visible = false
			CenterPos.get_node("shot_360").visible = true
	if (Joystick.get_node("joystick_button").where_is_joystick_btn() == 0 and can_fire == true and PlayerVars.player_is_dead == false):
			#print("center")
			CenterPos.get_node("shot_360").visible = false
			CenterPos.get_node("shot_angle").visible = false
			#OuterPos.get_node("LightAim").visible = false
	if (Joystick.get_node("joystick_button").where_is_joystick_btn() == -1 and can_fire == true and PlayerVars.player_is_dead == false):
			#print("outside")
			#apply_central_impulse(Vector2(linear_velocity * lerp(-0.02, -1, slow_down)))
			CenterPos.set_rotation_degrees(Joystick.get_node("joystick_button").get_angle() + 180)
			CenterPos.get_node("shot_angle").visible = true
			#OuterPos.get_node("LightAim").visible = true
			CenterPos.get_node("shot_360").visible = false

func WaveLoopJoystickCenter():
	if (Joystick.get_node("joystick_button").is_released_center() and can_fire == true and PlayerVars.player_is_dead == false):
		can_fire = false
		angle_steps = 0.0
		#I use for to spawn multiple balls at one shot 36 is number_of_balls
		for _b in range(0,36):
			var balls_instance = balls.instance()
			balls_instance.set_position(self.position)
			balls_instance.set_rotation(angle_steps)
			angle_steps += 10
			get_parent().add_child(balls_instance)
		yield(get_tree().create_timer(rate_of_fire),"timeout")
		can_fire = true

func WaveLoopJoystickAngle():
	if (Joystick.get_node("joystick_button").is_not_released_center() and can_fire == true and PlayerVars.player_is_dead == false):
		can_fire = false
		angle_steps = Joystick.get_node("joystick_button").get_angle() + 180
		#self.apply_central_impulse(Joystick.get_node("joystick_button").get_button_pos() * -1.2)
		CenterPos.set_rotation_degrees(angle_steps)
		angle_steps = angle_steps - 10
		#I use for to spawn multiple balls at one shot 36 is number_of_balls
		for _b in range(0,20):
			var balls_instance = balls.instance()
			balls_instance.set_position(self.position)
			balls_instance.set_rotation(deg2rad(angle_steps))
			balls_instance.projectile_speed = rand_range(350,400)
			angle_steps += 1
			get_parent().add_child(balls_instance)
		yield(get_tree().create_timer(rate_of_fire),"timeout")
		can_fire = true

func _on_RigidBody2D_body_entered(body):
	play_hit_sound()
#	print(body.name)
#	print(body.get_collision_layer())
	if body.get_collision_layer_bit(3) == true && body.get_collision_mask_bit(3) == true && PlayerVars.player_is_dead == false && body.get_collision_layer_bit(5) == false:
		player_dies(body)
#	if body.get_collision_layer() == 9 and PlayerVars.player_is_dead == false:
#		player_dies(body)
#	if body.get_collision_layer() == 13 and PlayerVars.player_is_dead == false:
#		player_dies(body)
#	if body.get_collision_layer() == 15 and PlayerVars.player_is_dead == false and body.get_linear_velocity().length() > 40:
#		player_dies(body)
	if PlayerVars.player_is_dead == false and self.get_linear_velocity().length() > 40 && body.get_collision_layer_bit(5) == false:
		player_dies(body)

func player_dies(body):
		if PlayerVars.sfx:
			breaking_sound.play()
		#====2 rigedbody is spawning on player
		var dead_body_instance = dead_body.instance()
		dead_body_instance.set_position(self.position)
		dead_body_instance.set_rotation(self.position.angle_to_point(body.position))
#		get_parent().add_child(dead_body_instance)
		get_parent().call_deferred("add_child", dead_body_instance)
		#====other stuff
		PlayerVars.player_is_dead = true
		set_collision_layer(0)
		set_collision_mask(0)
		hide()
		GlowingParticles.hide()
		ControlJoystick.hide()
		CenterPos.get_node("shot_360").hide()
		CenterPos.get_node("shot_angle").hide()
		yield(get_tree().create_timer(5),"timeout")
		get_tree().paused = false
		if get_tree().reload_current_scene() != OK:
			print ("An unexpected error occured when trying to reload to the current scene")

func player_flash(body):
		#====for going in prtals
		var dead_body_flash_instance = dead_body_flash.instance()
		dead_body_flash_instance.set_position(self.position)
		dead_body_flash_instance.set_rotation(self.position.angle_to_point(body.position))
#		get_parent().add_child(dead_body_flash_instance)
		get_parent().call_deferred("add_child", dead_body_flash_instance)
		#====other stuff
		PlayerVars.player_is_dead = true
		set_collision_layer(0)
		set_collision_mask(0)
		hide()
		GlowingParticles.hide()
		ControlJoystick.hide()
		CenterPos.get_node("shot_360").hide()
		CenterPos.get_node("shot_angle").hide()

#============this function is for kill the player if player_must_die is true
func player_must_die():
		if PlayerVars.sfx:
			breaking_sound.play()
		#====2 rigedbody is spawning on player
		var dead_body_instance = dead_body.instance()
		dead_body_instance.set_position(self.position)
#		dead_body_instance.set_rotation(self.position.angle_tod_point(body.position))
#		get_parent().add_child(dead_body_instance)
		get_parent().call_deferred("add_child", dead_body_instance)
		#====other stuff
		PlayerVars.player_is_dead = true
		set_collision_layer(0)
		set_collision_mask(0)
		hide()
		GlowingParticles.hide()
		ControlJoystick.hide()
		CenterPos.get_node("shot_360").hide()
		CenterPos.get_node("shot_angle").hide()
		yield(get_tree().create_timer(5),"timeout")
		get_tree().paused = false
		if get_tree().reload_current_scene() != OK:
			print ("An unexpected error occured when trying to reload to the current scene")


func _on_PlayerRigidBody_body_exited(body):
	time_start = OS.get_ticks_msec()
	pass # Replace with function body.

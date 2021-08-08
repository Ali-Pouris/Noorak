extends Node2D

onready var pin_1 = get_node("Pin_glass_LD")
onready var pin_2 = get_node("Pin_glass_LT")
onready var pin_3 = get_node("Pin_glass_RD")
onready var pin_4 = get_node("Pin_glass_RT")

onready var main_body = get_node("RigidBody2D")
onready var saw_1 = get_node("Rigid_Down")
onready var saw_2 = get_node("Rigid_Left")
onready var saw_3 = get_node("Rigid_right")
onready var saw_4 = get_node("Rigid_up")

onready var anim = get_node("BossFigh_H")

onready var eye = get_node("eye")

onready var player = get_node("../player/PlayerRigidBody")

onready var particles_up = get_node("RigidBody2D/CPUParticles2D_up")
onready var particles_down = get_node("RigidBody2D/CPUParticles2D_down")
onready var particles_left = get_node("RigidBody2D/CPUParticles2D_left")
onready var particles_right = get_node("RigidBody2D/CPUParticles2D_right")
#onready var one_time : bool = false
onready var triger : bool = false

#var time_start = 0
#var time_now = 0
   

# Called when the node enters the scene tree for the first time.
#func _ready():
#	time_start = OS.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	eye.set_position(main_body.position)
	eye.rotation_degrees = rad2deg(eye.get_global_position().angle_to_point(player.position)) + 180
	if !triger:
		if pin_1 == null && !particles_left.emitting:
			particles_left.set_emitting(true)
		if pin_2 == null && !particles_up.emitting:
			particles_up.set_emitting(true)
		if pin_3 == null && !particles_down.emitting:
			particles_down.set_emitting(true)
		if pin_4 == null && !particles_right.emitting:
			particles_right.set_emitting(true)
		
		if pin_1 == null && pin_2 == null && pin_3 == null && pin_4 == null:
			triger = true
			print("boss is dead")
			anim.stop()
			saw_1.applied_torque = 0
			saw_2.applied_torque = 0
			saw_3.applied_torque = 0
			saw_4.applied_torque = 0
			saw_1.gravity_scale = 1
			saw_2.gravity_scale = 1
			saw_3.gravity_scale = 1
			saw_4.gravity_scale = 1
			saw_1.bounce = 0
			saw_2.bounce = 0
			saw_3.bounce = 0
			saw_4.bounce = 0
			main_body.applied_torque = 0
			main_body.bounce = 0
			main_body.applied_force = Vector2.ZERO
			main_body.gravity_scale = 1
			
			
#		time_now = OS.get_ticks_msec()
#		var time_elapsed = time_now - time_start
#		if time_elapsed > 1500:
#			time_start = OS.get_ticks_msec()
#			print(time_elapsed)
	pass

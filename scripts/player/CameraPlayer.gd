extends Camera2D

onready var parent = $'../PlayerRigidBody'

#======ZOOM==========
var smooth_zoom = 1.0
var target_zoom = 1.0

const ZOOM_SPEED = 1
#====================

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(_delta):
	update_camera_zoom()


#================ZOOM=============
func update_camera_zoom():
	if PlayerVars.player_is_dead == false:
		if parent.look_direction.length() > 100:
			target_zoom = 1.5
		if parent.look_direction.length() < 50:
			target_zoom = 1.0
		smooth_zoom = lerp(smooth_zoom, target_zoom, ZOOM_SPEED * get_physics_process_delta_time())
		if smooth_zoom != target_zoom:
			set_zoom(Vector2(smooth_zoom, smooth_zoom))


extends Control

onready var scene_tree: = get_tree()
onready var touch_controls: = get_node("TouchControls")
onready var corner_pause_btn: = get_node("Pause")
onready var corner_retry_btn: = get_node("Retry")
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var joystick_and_extrabtn = get_node("../../player/CanvasLayer/Control")

onready var cb_music = get_node("PauseOverlay/CheckBoxMusic")
onready var cb_sfx = get_node("PauseOverlay/CheckBoxSFX")
onready var anim = get_node("AnimationPlayer")

var paused: = false setget set_paused

func _ready():
	MusicControler.stop_playing()
	cb_music.set_pressed(false)
	cb_sfx.set_pressed(PlayerVars.sfx)

func _physics_process(_delta):
	if PlayerVars.player_is_dead == true:
		hide()


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused = !paused
		touch_controls.visible = !paused
		joystick_and_extrabtn.visible = !paused
		corner_pause_btn.visible = !paused
		corner_retry_btn.visible = !paused
		scene_tree.set_input_as_handled()

func set_paused(value: bool):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value


#==corner righ btn
func _on_retry_btn_released():
	#======Full restart delete all the checkpoints
#	PlayerVars.reset_checkpoints()
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print ("An unexpected error occured when trying to reload the current scene")

#==corner left btn
func _on_resume_btn_released():
	self.paused = !paused
	touch_controls.visible = !paused
	joystick_and_extrabtn.visible = !paused
	corner_pause_btn.visible = !paused
	corner_retry_btn.visible = !paused
	anim.play("fade_in")



#func _on_CheckBoxMusic_pressed():
#	PlayerVars.music = cb_music.pressed
#	if PlayerVars.music:
#		MusicControler.play_menu_music()
#	else:
#		MusicControler.stop_playing()


func _on_CheckBoxSFX_pressed():
	PlayerVars.sfx = cb_sfx.pressed


func _on_Resume_pressed():
	self.paused = !paused
	touch_controls.visible = !paused
	joystick_and_extrabtn.visible = !paused
	corner_pause_btn.visible = !paused
	corner_retry_btn.visible = !paused


func _on_Restart_pressed():
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print ("An unexpected error occured when trying to reload the current scene")


func _on_Mainmenu_pressed():
	self.paused = !paused
	if get_tree().change_scene("res://Scenes/Interface_scenes/MainMenu.tscn") != OK:
		print ("An unexpected error occured when trying to switch to the MainMenu scene")

extends TouchScreenButton
#The radius of small circle
var radius = Vector2(10,10)
#the boundry joystic
var marz = 20
#for not following outside of jostick
var ongoing_drag = -1
#the speed for small circle to return to the center after release
var return_accel = 64
#joystick not giving a value in this range
var threshold = 9
#joystick opasity max and min
var joystick_opacity_max = 0.9
var joystick_opacity_min = 0.6
#variables for knowing where is the button during a press or release
var is_btn_relesed_in_center = false
var is_btn_not_relesed_in_center = false


func get_button_pos():
	return position + radius

#for backing the small circle to the center
func _process(_delta):
	if ongoing_drag == -1:
		#set joystick opacity to min value
		get_parent().modulate.a = joystick_opacity_min
		self.modulate.a = 1
		#What the distance between the small circle and the center
		var pos_difference = (Vector2(0,0) - radius) - position
		#position += pos_difference * return_accel * delta
		position += pos_difference
#	if get_tree().is_paused():
#		visible = false
#		get_parent().visible = false
#	else:
#		visible = true
#		get_parent().visible = true


func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		
		#set joystick opacity to max value
		get_parent().modulate.a = joystick_opacity_max
		#put the hole joystick where touch accured
		#if event.get_index() != ongoing_drag:
			#get_parent().global_position = event.position
		#check if the touch inside the joystick or not
		var event_dist_from_center = (event.position - get_parent().global_position).length()
		
		if event_dist_from_center <= marz * global_scale.x or event.get_index() == ongoing_drag:
			#set small circle to the middle of the touch
			set_global_position(event.position - radius * global_scale)
			#check if small circle is in the boundry or not
			if get_button_pos().length() > marz:
				set_position(get_button_pos().normalized() * marz - radius)
			#keep track of the finger index
			ongoing_drag = event.get_index()
	#let it go the small circle
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1



#get value
func get_value():
	#check if small circle is out off a threshold radius(zone)
	if get_button_pos().length() > threshold:
		return get_button_pos()
	return Vector2(0,0)

#get angle
func get_angle():
	if get_button_pos().length() > threshold:
		return rad2deg(Vector2(0,0).angle_to_point(get_button_pos()))
	return 0

#==========================================
#		When btn release actions
#==========================================
#get 360 shot
func is_released_center():
	if is_btn_relesed_in_center:
		is_btn_relesed_in_center = !is_btn_relesed_in_center
		return true
	else:
		return false

# get angle shot
func is_not_released_center():
	if is_btn_not_relesed_in_center:
		is_btn_not_relesed_in_center = !is_btn_not_relesed_in_center
		return true
	else:
		return false
#===========================================
#		When btn presss actions
#===========================================
func where_is_joystick_btn():
	if get_button_pos().length() == 0:
		return 0
	if get_button_pos().length() < threshold:
		return 1
	if get_button_pos().length() > threshold:
		return -1


func _on_joystick_button_released():
	if get_button_pos().length() < threshold:
		is_btn_relesed_in_center = true
	if get_button_pos().length() > threshold:
		is_btn_not_relesed_in_center = true

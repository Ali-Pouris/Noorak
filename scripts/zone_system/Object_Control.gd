extends Node2D

onready var object_positions : PoolVector2Array
onready var object_rotations : Array
onready var object_id : Array
onready var objects = get_node("Objects")
onready var vis = get_node("VisibilityNotifiers")
onready var once : bool = false

#onready var zone_1 = preload("res://Scenes/Levels/Testing_Levels/zone_testing_stuff/Zone_1.tscn")
#onready var zone_2 = preload("res://Scenes/Levels/Testing_Levels/zone_testing_stuff/Zone_2.tscn")
export (String, FILE) var object_path_0
export (String, FILE) var object_path_1
export (String, FILE) var object_path_2
export (String, FILE) var object_path_3
export (String, FILE) var object_path_4
export (String, FILE) var object_path_5
export (String, FILE) var object_path_6
export (String, FILE) var object_path_7
export (String, FILE) var object_path_8
export (String, FILE) var object_path_9

onready var object_0
onready var object_1
onready var object_2
onready var object_3
onready var object_4
onready var object_5
onready var object_6
onready var object_7
onready var object_8
onready var object_9


#var lol = preload(object_path_0)

# Called when the node enters the scene tree for the first time.
func _ready():
#	yield(get_tree().create_timer(0.01),"timeout")
	if object_path_0 != "":
		object_0 = load(object_path_0)
	if object_path_1 != "":
		object_1 = load(object_path_1)
	if object_path_2 != "":
		object_2 = load(object_path_2)
	if object_path_3 != "":
		object_3 = load(object_path_3)
	if object_path_4 != "":
		object_4 = load(object_path_4)
	if object_path_5 != "":
		object_5 = load(object_path_5)
	if object_path_6 != "":
		object_6 = load(object_path_6)
	if object_path_7 != "":
		object_7 = load(object_path_7)
	if object_path_8 != "":
		object_8 = load(object_path_8)
	if object_path_9 != "":
		object_9 = load(object_path_9)
	
	var i = 0
	for child in objects.get_children():
		object_positions.append(child.position)
		object_rotations.append(child.rotation)
		object_id.append(int(child.name[1]))
		child.queue_free()
		i += 1
	
	
	var n = 0
	for child in vis.get_children():
		child.connect("screen_entered", self, "load_zone",[n, object_id[n]])
		child.connect("screen_exited", self, "unload_zone",[n])
		n += 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if !once:
#		for child in objects.get_children():
#			if child.name[0] == "@":
#				child.queue_free()
#				once = true
#	pass


func load_zone(number,id):
#	print("object " + str(number) + " is loaded!")
	var object
	if id == 0:
		object = object_0.instance()
	if id == 1:
		object = object_1.instance()
	if id == 2:
		object = object_2.instance()
	if id == 3:
		object = object_3.instance()
	if id == 4:
		object = object_4.instance()
	if id == 5:
		object = object_5.instance()
	if id == 6:
		object = object_6.instance()
	if id == 7:
		object = object_7.instance()
	if id == 8:
		object = object_8.instance()
	if id == 9:
		object = object_9.instance()
	
	object.set_position(object_positions[number])
	object.set_rotation(object_rotations[number])
	object.name = str(number)
	
	objects.add_child(object)


func unload_zone(number):
#	print("object " + str(number) + " is unloaded!")
	for child in objects.get_children():
		if child.name == str(number):
			object_positions[number] = child.position
			object_rotations[number] = child.rotation
			child.queue_free()


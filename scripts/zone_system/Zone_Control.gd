extends Node2D

onready var zone_positions : PoolVector2Array
onready var zone_rotations : Array
onready var zone_id : Array
onready var zones = get_node("Zones")
onready var vis = get_node("VisibilityNotifiers")
onready var once : bool = false

#onready var zone_1 = preload("res://Scenes/Levels/Testing_Levels/zone_testing_stuff/Zone_1.tscn")
#onready var zone_0 = preload("res://Scenes/Levels/Testing_Levels/zone_testing_stuff/Zone_2.tscn")

export (String, FILE) var zone_path_0
export (String, FILE) var zone_path_1
export (String, FILE) var zone_path_2
export (String, FILE) var zone_path_3
export (String, FILE) var zone_path_4
export (String, FILE) var zone_path_5
export (String, FILE) var zone_path_6
export (String, FILE) var zone_path_7
export (String, FILE) var zone_path_8
export (String, FILE) var zone_path_9
export var store_rotation : bool = false

onready var zone_0
onready var zone_1
onready var zone_2
onready var zone_3
onready var zone_4
onready var zone_5
onready var zone_6
onready var zone_7
onready var zone_8
onready var zone_9


# Called when the node enters the scene tree for the first time.
func _ready():
	if store_rotation:
		var i = 0
		for child in zones.get_children():
			zone_positions.append(child.position)
			zone_rotations.append(child.rotation)
			zone_id.append(int(child.name[1]))
			child.queue_free()
			i += 1
	else:
		var i = 0
		for child in zones.get_children():
			zone_positions.append(child.position)
			zone_id.append(int(child.name[1]))
			child.queue_free()
			i += 1
	
	var n = 0
	for child in vis.get_children():
		child.connect("screen_entered", self, "load_zone", [n, zone_id[n]])
		child.connect("screen_exited", self, "unload_zone",[n])
		n += 1
	
	if zone_path_0 != "":
		zone_0 = load(zone_path_0)
	if zone_path_1 != "":
		zone_1 = load(zone_path_1)
	if zone_path_2 != "":
		zone_2 = load(zone_path_2)
	if zone_path_3 != "":
		zone_3 = load(zone_path_3)
	if zone_path_4 != "":
		zone_4 = load(zone_path_4)
	if zone_path_5 != "":
		zone_5 = load(zone_path_5)
	if zone_path_6 != "":
		zone_6 = load(zone_path_6)
	if zone_path_7 != "":
		zone_7 = load(zone_path_7)
	if zone_path_8 != "":
		zone_8 = load(zone_path_8)
	if zone_path_9 != "":
		zone_9 = load(zone_path_9)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(_delta):
#	if !once:
#		for child in zones.get_children():
#			if child.name[0] == "@":
#				child.name = child.name[1]
#				once = true



func load_zone(number,id):
#	print("zone " + str(number) + " is loaded!")
	var zone
	if id == 0:
		zone = zone_0.instance()
	if id == 1:
		zone = zone_1.instance()
	if id == 2:
		zone = zone_2.instance()
	if id == 3:
		zone = zone_3.instance()
	if id == 4:
		zone = zone_4.instance()
	if id == 5:
		zone = zone_5.instance()
	if id == 6:
		zone = zone_6.instance()
	if id == 7:
		zone = zone_7.instance()
	if id == 8:
		zone = zone_8.instance()
	if id == 9:
		zone = zone_9.instance()
		
	zone.set_position(zone_positions[number])
	if store_rotation:
		zone.set_rotation(zone_rotations[number])
	zone.name = str(number)
		
	zones.add_child(zone)
	


func unload_zone(number):
#	print("zone " + str(number) + " is unloaded!")
	for child in zones.get_children():
		if child.name == str(number):
			child.queue_free()


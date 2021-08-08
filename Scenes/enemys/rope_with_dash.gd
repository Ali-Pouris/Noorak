extends Node2D


export var rope_length = 5
export var rope_size: float = 4
export var pin_softness: float = 0
export var new_gravity: int = 0
export var top_gravity : bool = false


#onready var line = get_node("Line2D")
onready var rig_arr : Array = []
onready var pin_arr : Array = []
onready var rig_pos : Array = []
onready var line = Line2D.new()
onready var first_pin = get_node("PinJoint2D")

var dash_spike = preload("res://Scenes/enemys/DashSpik.tscn")
var dash = dash_spike.instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rig_holder
	var coll_holder
	var pin_holder
	
	var coll_shape = RectangleShape2D.new()
	for i in range(0,rope_length):
		rig_holder = RigidBody2D.new()
		rig_holder.set_position(Vector2(0,i*(rope_size * 2)))
		rig_holder.set_mass(0.1)
		rig_holder.set_collision_layer(0)
		rig_holder.set_collision_layer_bit(6, true)
		rig_holder.set_collision_layer_bit(2, true)
		rig_holder.set_collision_mask_bit(6, true)
		rig_holder.set_collision_mask_bit(2, true)
		if top_gravity:
			rig_holder.set_gravity_scale(-1)
		if new_gravity != 0:
			rig_holder.set_collision_layer_bit(10, true)
			rig_holder.set_collision_mask_bit(10, true)
		coll_holder = CollisionShape2D.new()
		coll_holder.set_shape(coll_shape)
		coll_shape.set_extents(Vector2(0.5,rope_size))
		coll_holder.set_position(Vector2(0,rope_size))
		pin_holder = PinJoint2D.new()
		pin_holder.set_softness(pin_softness)
		if i < rope_length -1:
			pin_holder.set_position(Vector2(0,(i+1)*(rope_size * 2)))
		else:
			pin_holder.set_position(Vector2(0,(rope_length)*(rope_size * 2)))
		
		add_child(rig_holder)
		rig_holder.add_child(coll_holder)
		add_child(pin_holder)
		
		rig_arr.append(rig_holder)
		pin_arr.append(pin_holder)
		
		#==set pin node A
		pin_holder.set_node_a(rig_holder.get_path())
		
		if i == 0 :
			first_pin.set_node_b(rig_holder.get_path())
		
		if i == rope_length - 1:
			dash.set_position(Vector2(0,(rope_length)*(rope_size * 2)))
			dash.set_rotation_degrees(rotation_degrees * -1)
			if top_gravity:
				dash.set_gravity_scale(-1)
			else:
				dash.set_gravity_scale(1)
			dash.set_z_index(1)
			if new_gravity != 0:
				dash.set_collision_layer_bit(10, true)
				dash.set_collision_mask_bit(10, true)
			var dash_pin = PinJoint2D.new()
			dash_pin.set_position(Vector2(0,(i + 1)*(rope_size * 2)))
			dash_pin.set_softness(pin_softness)
			add_child(dash_pin)
			add_child(dash)
			dash_pin.set_node_a(rig_arr[rope_length - 1].get_path())
			dash_pin.set_node_b(dash.get_path())
			dash.apply_impulse(Vector2(0,0),Vector2(1,0))
	
	for j in range(0, rope_length):
		if j + 1 != rope_length:
			pin_arr[j].set_node_b(rig_arr[j+1].get_path())
	
	
	line.set_width(1)
	line.default_color = Color(0,0,0)
	add_child(line)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rig_pos.append(Vector2(0,-4))
	for r in rig_arr:
		rig_pos.append(r.position)
	rig_pos.append(dash.position)
	line.set_points(rig_pos)
	rig_pos.clear()
	pass

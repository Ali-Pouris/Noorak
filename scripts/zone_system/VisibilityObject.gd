extends VisibilityNotifier2D

onready var is_on_screen : bool = false
onready var the_object
onready var objects = get_node("../../Objects")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in objects.get_children():
		if child.name == self.name:
			the_object = child
	self.connect("screen_entered", self, "screen_entered")
	self.connect("screen_exited", self, "screen_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_on_screen:
		if the_object != null:
			self.set_position(the_object.position)


func screen_entered():
	for child in objects.get_children():
		if child.name == self.name:
			the_object = child
	is_on_screen = true


func screen_exited():
	is_on_screen = false


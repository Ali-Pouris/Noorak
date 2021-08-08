extends Node2D

func _ready():
	get_node("Particles2D").set_emitting(true)
	
	#change all the colors
	var data = SaveLoad.load_the_game()
	if data != null:
		get_node("RigidBody2D/Sprite").modulate = data["spot_color"]
		get_node("RigidBody2D2/Sprite").modulate = data["spot_color"]
		get_node("RigidBody2D/Sprite").modulate.a = 0.7
		get_node("RigidBody2D2/Sprite").modulate.a = 0.7
		get_node("Particles2D").modulate = data["g_particles_color"]
		get_node("light_flash").modulate = data["light_color"]
	else:
		get_node("RigidBody2D/Sprite").modulate = PlayerVars.spot_color
		get_node("RigidBody2D2/Sprite").modulate = PlayerVars.spot_color
		get_node("RigidBody2D/Sprite").modulate.a = 0.7
		get_node("RigidBody2D2/Sprite").modulate.a = 0.7
		get_node("Particles2D").modulate = PlayerVars.g_particles_color
		get_node("light_flash").modulate = PlayerVars.light_color
		get_node("light_flash").modulate.a = PlayerVars.light_color_alpha

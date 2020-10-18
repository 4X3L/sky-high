extends KinematicBody2D

# https://docs.godotengine.org/en/stable/classes/class_node2d.html
# https://docs.godotengine.org/en/stable/tutorials/physics/using_kinematic_body_2d.html
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html#groups

# Our velocity
var velocity = Vector2(0, 0)
export var GRAVITY : float = 20
export var JUMP_POWER : float = 2
export var JUMP_POWER_FIXED : float = 1000
export var FIXED : bool = false

func _ready():
	velocity[0] = 0
	velocity[1] = 0
	
# Called on input
func _input(event):
	if event.is_action_pressed("game_click"):
		#velocity[1] = -800
		
		velocity = get_viewport().get_mouse_position() - position
		
		if FIXED:
			velocity = velocity.normalized() * JUMP_POWER_FIXED
		else:
			velocity = velocity * JUMP_POWER
		
	

func _gravity():
	velocity[1] = velocity[1] + GRAVITY

func _on_plaform_land(delta, collision_data):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the position of the player and check for collisions 
	var collision_data = move_and_collide(velocity * delta)

	if collision_data:
		var groups = collision_data.collider.get_groups()
		
		# Did we hit a platform or a wall?
		if "Platforms" in groups:
			print("Platform found!")
			_on_plaform_land(delta, collision_data)
		elif "Walls" in groups:
			print("Wall found!")
			velocity[0] = - velocity[0]
			_gravity()
		else:
			print("Colidded with: ", collision_data.collider.name)
	else:
		_gravity()



func _on_fries_get(body):
	print("I THE PLAYER GOT THE FRIES")
	# TODO how do I call this?
	

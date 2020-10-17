extends KinematicBody2D

# https://docs.godotengine.org/en/stable/classes/class_node2d.html
# https://docs.godotengine.org/en/stable/tutorials/physics/using_kinematic_body_2d.html
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html#groups

# Our velocity
const velocity = Vector2(0, 0)
const GRAVITY = 20

func _ready():
	velocity[0] = 0
	velocity[1] = 0
	
# Called on input
func _input(event):
	if event.is_action("game_click"):
		velocity[1] = -800

func _gravity():
	velocity[1] = velocity[1] + GRAVITY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the position of the player and check for collisions 
	var collision_data = move_and_collide(velocity * delta)

	if collision_data:
		var groups = collision_data.collider.get_groups()
		
		# Did we hit a platform or a wall?
		if "Platforms" in groups:
			print("Platform found!")
			# TODO add platform code
		elif "Walls" in groups:
			print("Wall found!")
			velocity[0] = - velocity[0]
			_gravity()
	else:
		_gravity()

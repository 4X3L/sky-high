extends KinematicBody2D

# https://docs.godotengine.org/en/stable/classes/class_node2d.html
# https://docs.godotengine.org/en/stable/tutorials/physics/using_kinematic_body_2d.html
# https://docs.godotengine.org/en/stable/getting_started/step_by_step/scripting_continued.html#groups

# Our velocity
var velocity = Vector2(0, 0)
# Friction with other objects, reduces velocity
var bounceDamp = 0.7
var bounceClamp = 1
var friction = 1
var slideClamp = 0.1

export var GRAVITY : float = 20
export var JUMP_POWER : float = 2
export var JUMP_POWER_FIXED : float = 1000
export var FIXED : bool = false

# var my_sprite : Sprite = null
onready var my_sprite = $Sprite

func _ready():
	velocity[0] = 0
	velocity[1] = 0
	# my_sprite = get_node("Sprite") # TODO async?

# Called on input
func _input(event):
	if event.is_action_pressed("game_click"):
		#velocity[1] = -800
		
		velocity = get_viewport().get_mouse_position() - get_global_transform_with_canvas().origin 
		
		if FIXED:
			velocity = velocity.normalized() * JUMP_POWER_FIXED
		else:
			velocity = velocity * JUMP_POWER
		
	

func _gravity():
	velocity[1] = velocity[1] + GRAVITY

func _on_plaform_land(delta, collision_data):
	var oldv = velocity
	velocity = velocity.slide(collision_data.normal)
	if collision_data.travel[1] < bounceClamp:
		velocity[1] = 0
	else:
		velocity[1] = oldv[1] * -1 * bounceDamp
	#if collision_data.travel[0] < slideClamp:
		#velocity[0] = 0
	#else:
		#velocity[0] *= friction
	#velocity[0] *= friction 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Update the position of the player and check for collisions 
	var collision_data = move_and_collide(velocity * delta)

	# Update sprite
	my_sprite.set_flip_h( velocity[0] < 0 )

	if collision_data:
		var groups = collision_data.collider.get_groups()
		
		# Did we hit a platform or a wall?
		if "Platforms" in groups:
			_on_plaform_land(delta, collision_data)
		elif "Walls" in groups:
			velocity[0] = - velocity[0]
			_gravity()
		else:
			print("Colidded with: ", collision_data.collider.name)
	else:
		_gravity()


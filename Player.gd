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

export var GRAVITY : float = 15
export var JUMP_POWER : float = 4
export var JUMP_POWER_FIXED : float = 1000
export var FIXED : bool = false

export var TOTAL_JUMPS = 1
var curent_jumps
onready var my_sprite = $Sprite

export var JUMP_COLOR : Color = Color(.7, .7, 1)
export var NO_JUMP_COLOR : Color = Color(1, 1, 1)


func _ready():
	velocity[0] = 0
	velocity[1] = 0
	curent_jumps = 0
	_update_sprite()

func _update_sprite():
	# Direction
	my_sprite.set_flip_h( velocity[0] < 0 )
	# Color
	if curent_jumps > 0:
		my_sprite.modulate = JUMP_COLOR
	else:
		my_sprite.modulate = NO_JUMP_COLOR

func _jump():
	var direction = get_viewport().get_mouse_position() - get_global_transform_with_canvas().origin 
	if FIXED:
		velocity = direction.normalized() * JUMP_POWER_FIXED
	else:
		velocity = direction * JUMP_POWER

# Called on input
func _input(event):
	if event.is_action_pressed("game_click"):
		if curent_jumps > 0:
			_jump()
			curent_jumps -= 1
		_update_sprite()
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _gravity():
	velocity[1] = velocity[1] + GRAVITY

func _on_plaform_land(delta, collision_data):
	curent_jumps = TOTAL_JUMPS
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

	if collision_data:
		var groups = collision_data.collider.get_groups()
		
		# Did we hit a platform or a wall?
		if "Platforms" in groups:
			_on_plaform_land(delta, collision_data)
		elif "Walls" in groups:
			#velocity[0] = - velocity[0]
			velocity -= 2 * (velocity.dot(collision_data.normal) * collision_data.normal)
			_gravity()
		else:
			print("Colidded with: ", collision_data.collider.name)
		
		if collision_data.collider.name == "BackGrounds":
			var cv = collision_data.collider.get_cellv(collision_data.collider.world_to_map(position))
			if cv == 5 and collision_data.normal == Vector2(0, -1): # five is just the tile id of the starting tile
				velocity = Vector2(0,0)
				curent_jumps = 1
		_update_sprite()
	else:
		_gravity()


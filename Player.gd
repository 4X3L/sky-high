extends KinematicBody2D

# https://docs.godotengine.org/en/stable/classes/class_node2d.html
# https://docs.godotengine.org/en/stable/tutorials/physics/using_kinematic_body_2d.html


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const velocity = Vector2(100, 100)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_data = move_and_collide(velocity * delta)

	if collision_data:
		print("I hit ", collision_data.collider.name)
		velocity[1] = - velocity[1]
	
	#position[0] = position[0] + ( xVelocity * delta )
	#position[1] = position[1] + ( yVelocity * delta )

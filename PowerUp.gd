extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var xVelocity = 20
var yVelocity = 10
var yDirection = -1
var num_frames = 0
var time_one_direction = 0
var switch_time = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position[1] = position[1] + (yDirection * yVelocity * delta)
	time_one_direction += delta
	if time_one_direction > switch_time:
		yDirection *= -1
		time_one_direction = 0
	
	
	
	#num_frames += 1
	#if num_frames == 50:
	#	yDirection = 1
	#elif num_frames == 100:
	#	yDirection = -1
	#	num_frames = 0

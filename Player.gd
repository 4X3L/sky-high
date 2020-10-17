extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var xVelocity = 20
var yVelocity = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position[0] = position[0] + ( xVelocity * delta )
	position[1] = position[1] + ( yVelocity * delta )

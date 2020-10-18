extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var xVelocity = 20
var yVelocity = 200
#need to change it to reference the "Player" node
onready var node = get_node("/root/Node2D/Fries")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Should not need the "yDirection" part for the Player node
	position[1] = position[1] - (node.yDirection * node.yVelocity * delta)

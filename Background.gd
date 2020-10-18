extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# var xVelocity = 20

var velocity = -10

onready var node = get_node("/root/Node2D/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var oldY = 0.0
var hasDiff = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hasDiff: 
		#Should not need the "yDirection" part for the Player node
		position[1] -= (oldY - node.position[1]) * velocity * delta
	hasDiff = true
	oldY = node.position[1]

extends Node2D
# TODO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var yPlayer : float = 0.0
var friesScn = load("res://Fries.tscn")
var friesList = []
var minBounds = 0
var maxBounds = 0
var spawnDist = 200000
var spawnPerRange = 100
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawnInRange(ub, lb):
	for _i in range(0,spawnPerRange):
		var newFries = friesScn.instance()
		var viewWidth = get_viewport().size.x
		newFries.position[0] = rng.randf_range(0, viewWidth)
		newFries.position[1] = rng.randf_range(lb, ub)
		friesList.append(newFries)
		add_child_below_node(get_tree().get_root(), newFries)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	while abs(minBounds - yPlayer) < spawnDist:
		spawnInRange(minBounds, minBounds-spawnDist)
		minBounds -= spawnDist
	while abs(maxBounds - yPlayer) < spawnDist:
		spawnInRange(maxBounds + spawnDist, maxBounds)
		maxBounds += spawnDist
	
	

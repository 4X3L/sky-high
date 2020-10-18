extends Node2D
# TODO

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var yPlayer : float = 0.0
var potatoScn = load("res://Potat.tscn")
var potatoList = []
var minBounds = 0
var maxBounds = 0
var spawnDist = 800
var spawnPerRange = 5
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawnInRange(ub, lb):
	for _i in range(0,spawnPerRange):
		var newPlat = potatoScn.instance()
		var viewWidth = get_viewport().size.x
		newPlat.position[0] = rng.randf_range(0, viewWidth)
		newPlat.position[1] = rng.randf_range(lb, ub)
		newPlat.add_to_group("Platforms")
		potatoList.append(newPlat)
		add_child_below_node(get_tree().get_root(), newPlat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	while abs(minBounds - yPlayer) < spawnDist:
		spawnInRange(minBounds, minBounds-spawnDist)
		minBounds -= spawnDist
	while abs(maxBounds - yPlayer) < spawnDist:
		spawnInRange(maxBounds + spawnDist, maxBounds)
		maxBounds += spawnDist
	
	

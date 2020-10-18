extends Node2D

var platformScn = load("res://Platform.tscn")
var platformList = []
var platcount = 1000
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var bottom = 5120
	var top = -16384
	var left = 0
	var right = 1024
	for _i in range(0,platcount):
		var newPlat = platformScn.instance()
		var viewWidth = get_viewport().size.x
		newPlat.position[0] = rng.randf_range(left, right)
		newPlat.position[1] = rng.randf_range(top, bottom)
		newPlat.add_to_group("Platforms")
		platformList.append(newPlat)
		add_child_below_node(get_tree().get_root(), newPlat)
	

func spawnInRange(ub, lb):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

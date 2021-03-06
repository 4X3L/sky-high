extends Node2D

var platformScn = load("res://Potat.tscn")
var platformList = []
var platcount = 85
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = OS.get_ticks_usec() * 3
	var bottom = 5120
	var top = -16384
	var left = 0
	var right = 1024
	for _i in range(0,platcount):
		var newPlat = platformScn.instance()
		var viewWidth = get_viewport().size.x
		newPlat.position[0] = rng.randf_range(left, right)
		newPlat.position[1] = rng.randf_range(top, bottom)
		platformList.append(newPlat)
		call_deferred("add_child", newPlat)
	

func spawnInRange(ub, lb):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

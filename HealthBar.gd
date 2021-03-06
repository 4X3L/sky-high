extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var SCREEN_WIDTH : float = 1000
export var curent_health_percent : float = 100
export var TIME_PER_PAIN :float = .25

var timer = null
func _set_up_timer():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_call")
	timer.set_wait_time(TIME_PER_PAIN)
	timer.set_one_shot(false)
	timer.start()
	
func _on_timer_call():
	curent_health_percent = curent_health_percent - 1
	if curent_health_percent <= 3: # 3 for a small ui fix
		_death()
	_update_bar()

func _death():
	get_tree().change_scene("res://GameOver.tscn")

func _update_bar():
	var health : float = curent_health_percent / 100
	var new_pos : float = (SCREEN_WIDTH * health) - SCREEN_WIDTH
	var inner_bar = get_child(0)
	inner_bar.position[0] = new_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	_update_bar()
	_set_up_timer()


func _on_add_health(amount):
	curent_health_percent = curent_health_percent + amount
	if curent_health_percent > 100:
		curent_health_percent = 100
	#print("Added ", amount, " to health.")

func __add_health(amount):
	pass # Replace with function body.

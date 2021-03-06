extends Area2D

signal add_health(amount)

# Declare member variables here. Examples:
var yVelocity = 30
var yDirection = -1
var num_frames = 0
var time_one_direction = 0
var switch_time = .5
export var HEALTH_BOOST = 5

onready var health_bar = $"/root/Node2D/CanvasLayer/HealthBar"

func _on_Player_body_entered(body):
	$"/root/Node2D/PSF".play()
	emit_signal("add_health", HEALTH_BOOST)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_on_Player_body_entered")
	self.connect("add_health", health_bar, "_on_add_health")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position[1] = position[1] + (yDirection * yVelocity * delta)
	time_one_direction += delta
	if time_one_direction > switch_time:
		yDirection *= -1
		time_one_direction = 0

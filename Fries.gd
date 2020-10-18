extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#export var PlayerNode : KinematicBody2D

func _on_Player_body_entered(body):
	print("Fries colected!")
	queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Here we go")
	self.connect("body_entered", self, "_on_Player_body_entered")
	var player_node = get_tree().get_nodes_in_group("Players")[0]
	# TODO this is jank ^
	self.connect("body_entered", player_node, "_on_fries_get")

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

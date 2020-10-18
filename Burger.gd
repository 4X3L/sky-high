extends Area2D

func _on_Player_body_entered(body):
	get_tree().change_scene("res://Winning.tscn")

func _ready():
	self.connect("body_entered", self, "_on_Player_body_entered")

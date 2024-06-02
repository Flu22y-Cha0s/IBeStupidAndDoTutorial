extends Area2D

@onready var player = get_node("/root/Game/Player")

signal fast_shot()

func _on_body_entered(body):
	if body == player:
		fast_shot.emit()

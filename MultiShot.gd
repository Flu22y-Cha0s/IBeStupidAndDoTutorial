extends Area2D

@onready var player = get_node("/root/Game/Player")

signal multi_shot()

func _on_body_entered(body):
	if body == player:
		queue_free()
		multi_shot.emit()

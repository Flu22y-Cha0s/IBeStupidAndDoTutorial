extends Area2D

@onready var player = get_node("/root/Game/Player")

func _on_body_entered(body):
	if body == player:
		queue_free()
		player.health = 100.00


extends Node2D

func _process(delta):
	self.global_position = get_global_mouse_position()

func play_anim():
	$AnimationPlayerCrosshair.stop()
	$AnimationPlayerCrosshair.play("Shoot")

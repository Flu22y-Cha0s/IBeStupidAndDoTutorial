extends CanvasLayer

func  _ready():
	## %GameOver.visible = false
	pass
	

func _on_player_health_depleted():
		$DeathAnimationPlayer.play("fade")
		## await get_tree().create_timer($DeathAnimationPlayer.current_animation_length + 0.01).timeout 
		
		## $DeathAnimationPlayer.pause()
		
		await get_tree().create_timer(5).timeout 
		get_tree().paused = false
		get_tree().reload_current_scene()

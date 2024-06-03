extends Area2D

var traveled_distance = 0

var moving = true

func _physics_process(delta):
	const SPEED = 1000
	const RANGE = 1200
	var direction = Vector2.RIGHT.rotated(rotation)
	if moving:
		position += direction * SPEED * delta
	
	traveled_distance +=SPEED * delta
	if traveled_distance > RANGE:
		$AnimationPlayerDisappear.play("disappear")
		## queue_free()
		
	


func _on_body_entered(body):
	## queue_free()
	$AnimationPlayerDisappear.play("disappear")
	if body.has_method("take_damage"):
		body.take_damage()
	
	moving = false

func appear_animation():
	$AnimationPlayerAppear.play("appear")



func _on_animation_player_disappear_animation_finished(disappear):
	queue_free()

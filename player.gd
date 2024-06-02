extends CharacterBody2D

signal health_depleted

var health = 100.0
var max_health = 100.0

const DAMAGE_RATE = 1.0

var powerup_time = 5

func _ready():
	$Timer.wait_time = powerup_time
	## $ProgressBar2.visible = false
	$ProgressBar2.max_value = powerup_time
	
	##const FAST_SHOT_PRELOADED = preload("res://FastShot.tscn")
	
	
	
	
	
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	%ProgressBar.value = health
	
	
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlaping_bodies = %HurtBox.get_overlapping_bodies()
	
	if overlaping_bodies.size() > 0:
		health -= DAMAGE_RATE * overlaping_bodies.size()
		
		if health <= 0:
			health_depleted.emit()
	
	%ProgressBar2.value = $Timer.time_left

func multi_shot():
	if $Gun.multi_shot:
		$Timer.start()
		$ProgressBar2/AnimationPlayerFadeMultiShot.play("MultiShotFadeIn")
	else:
		$Timer.start()
		$Gun.multi_shot = true
	
		if $Gun.fast_shot == false:
			$ProgressBar2/AnimationPlayerBar.play("FadeIn")
		##%Player.modulate = Color(0,0.1,0)
	
		## Icons
		$ProgressBar2/AnimationPlayerFadeMultiShot.play("MultiShotFadeIn")
		if $Gun.fast_shot:
			$ProgressBar2/AnimationPlayerMove.play("MoveAside")

func fast_shot():
	if $Gun.fast_shot:
		$Timer.start()
		$ProgressBar2/AnimationPlayerFadeFastShot.play("FastShotFadeIn")
	else:
		$Gun.fast_shot = true
		$Timer.start()
		
		if $Gun.multi_shot == false:
			$ProgressBar2/AnimationPlayerBar.play("FadeIn")
		##%Player.modulate = Color(0.1,0,0)
		
		## Icons
		$ProgressBar2/AnimationPlayerFadeFastShot.play("FastShotFadeIn")
		if $Gun.multi_shot:
			$ProgressBar2/AnimationPlayerMove.play("MoveAside")

func _on_timer_timeout():
	
	$ProgressBar2/AnimationPlayerBar.play("FadeOut")
	##%Player.modulate = Color(0,0,0)
	$ProgressBar2/AnimationPlayerFadeMultiShot.play("MultiShotFadeOut")
	$ProgressBar2/AnimationPlayerFadeFastShot.play("FastShotFadeOut")
	
	if $Gun.multi_shot && $Gun.fast_shot:
		$ProgressBar2/AnimationPlayerMove.play("MoveInside")
	
	$Gun.multi_shot = false
	$Gun.fast_shot = false

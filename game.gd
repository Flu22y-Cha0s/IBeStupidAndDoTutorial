extends Node2D

const ENEMY_SPAWN = true

var score = 0


var fast_shot_instance
var multi_shot_instance
var med_orb_instance

const WAVE1 = 10
const WAVE2 = 50
const WAVE3 = 200

var wave_max = 10
var prev_wave_max = 0

const FAST_SHOT_PRELOADED = preload("res://FastShot.tscn")
const MULTI_SHOT_PRELOADED = preload("res://MultiShot.tscn")
const MED_ORB_PRELOADED = preload("res://MedOrb.tscn")

func  _process(delta):
	## $CanvasLayer2/ProgressBar3.update_bar(score - prev_wave_max, wave_max)
	pass
	
	
func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var i = 0
	while i < 10:
		spawn_powerup("fast_shot")
		i += 1
		
	i = 0
	while i < 10:
		spawn_powerup("multi_shot")
		i += 1
		
	i = 0
	while i < 10:
		spawn_powerup("med_orb")
		i += 1
	
func spawn_mob():
	
	if ENEMY_SPAWN:
		var new_enemy
		var i = 0
		if score < WAVE1:
			wave_max = WAVE1
			prev_wave_max = 0
			i = snapped(randf_range(1,1), 1)
			$CanvasLayer2/Label.text = "Wave: 1"
		if score >= WAVE1 && score < WAVE2:
			wave_max = WAVE2
			prev_wave_max = WAVE1
			i = snapped(randf_range(1,2), 1)
			$CanvasLayer2/Label.text = "Wave: 2"
		if score >= WAVE2 && score < WAVE3:
			wave_max = WAVE3
			prev_wave_max = WAVE2
			i = snapped(randf_range(1,3), 1)
			$CanvasLayer2/Label.text = "Wave: 3"
		if score >= WAVE3:
			prev_wave_max = WAVE3
			wave_max = 9999
			i = snapped(randf_range(2,3), 1)
			$CanvasLayer2/Label.text = "Wave: ∞"
		
		
		if i == 1:
			new_enemy = preload("res://EnemyGreen.tscn").instantiate()
		if i == 2:
			new_enemy = preload("res://EnemyBlue.tscn").instantiate()
		if i == 3:
			new_enemy = preload("res://EnemyRed.tscn").instantiate()
			
			
		%PathFollow2D.progress_ratio = randf()
		new_enemy.global_position = %PathFollow2D.global_position
		add_child(new_enemy)

func _on_timer_timeout():
	spawn_mob()
	pass


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
	
func call_fast_shot():
	print("called function")
	if %Player.has_method("fast_shot"):
		%Player.fast_shot()
	
func call_multi_shot():
	if %Player.has_method("multi_shot"):
		%Player.multi_shot()

func spawn_powerup(name):
	
	var powerup_instance
	
	if name == "fast_shot":
		fast_shot_instance = FAST_SHOT_PRELOADED.instantiate()
		fast_shot_instance.global_position = Vector2(randf_range(-2900,2900), randf_range(-1900,1900))
		fast_shot_instance.connect("fast_shot",   call_fast_shot)
		add_child(fast_shot_instance)
	if name == "multi_shot":
		multi_shot_instance = MULTI_SHOT_PRELOADED.instantiate()
		multi_shot_instance.global_position = Vector2(randf_range(-2900,2900), randf_range(-1900,1900))
		multi_shot_instance.connect("multi_shot",   call_multi_shot)
		add_child(multi_shot_instance)
	if name == "med_orb":
		med_orb_instance = MED_ORB_PRELOADED.instantiate()
		med_orb_instance.global_position = Vector2(randf_range(-2900,2900), randf_range(-1900,1900))
		add_child(med_orb_instance)

func score_up(amount):
	score += amount
	if score == WAVE1 || score == WAVE2 || score == WAVE3:
		if score < WAVE1:
			wave_max = WAVE1
			prev_wave_max = 0
			
		if score >= WAVE1 && score < WAVE2:
			wave_max = WAVE2
			prev_wave_max = WAVE1
			
		if score >= WAVE2 && score < WAVE3:
			wave_max = WAVE3
			prev_wave_max = WAVE2
			
		if score >= WAVE3:
			prev_wave_max = WAVE3
			wave_max = 9999
			
	
	$CanvasLayer2/ProgressBar3.update_bar(score - prev_wave_max, wave_max)
	
	
	
	
	

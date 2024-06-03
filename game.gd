extends Node2D

const ENEMY_SPAWN = true

var score = 0


var fast_shot_instance
var multi_shot_instance
var med_orb_instance

var wave1 = 10
var wave2 = 50
var wave3 = 200



const FAST_SHOT_PRELOADED = preload("res://FastShot.tscn")
const MULTI_SHOT_PRELOADED = preload("res://MultiShot.tscn")
const MED_ORB_PRELOADED = preload("res://MedOrb.tscn")

func _process(delta):
	$CanvasLayer/Label.text = str(score)


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
		if score <= wave1:
			i = 1
		if score > wave1 && score <= wave2:
			i = snapped(randf_range(1,2), 1)
		if score > wave2 && score <= wave3:
			i = snapped(randf_range(1,3), 1)
		if score > wave3:
			i = snapped(randf_range(2,3), 1)
		
		
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

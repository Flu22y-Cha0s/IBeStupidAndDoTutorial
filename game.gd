extends Node2D

const ENEMY_SPAWN = true

var fast_shot_instance
var multi_shot_instance
var med_orb_instance

func _ready():
	
	const FAST_SHOT_PRELOADED = preload("res://FastShot.tscn")
	fast_shot_instance = FAST_SHOT_PRELOADED.instantiate()
	fast_shot_instance.global_position = Vector2(900, 1000)
	
	fast_shot_instance.connect("fast_shot",   call_fast_shot)
	
	add_child(fast_shot_instance)
	
	const MULTI_SHOT_PRELOADED = preload("res://MultiShot.tscn")
	multi_shot_instance = MULTI_SHOT_PRELOADED.instantiate()
	multi_shot_instance.global_position = Vector2(1000, 1000)
	
	multi_shot_instance.connect("multi_shot",   call_multi_shot)
	
	add_child(multi_shot_instance)
	
	const MED_ORB_PRELOADED = preload("res://MedOrb.tscn")
	med_orb_instance = MED_ORB_PRELOADED.instantiate()
	med_orb_instance.global_position = Vector2(1000, 700)
	
	add_child(med_orb_instance)
	
func spawn_mob():
	if ENEMY_SPAWN:
		var new_enemy = preload("res://enemy.tscn").instantiate()
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

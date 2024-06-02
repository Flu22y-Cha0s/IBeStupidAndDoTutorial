extends CharacterBody2D

var health = 1

@onready var player = get_node("/root/Game/Player")

func _ready():
	$Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()
	

func take_damage():
	health -= 1
	
	$Slime.play_hurt()
	
	if health == 0:
		const DEATH_SMOKE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var new_smoke = DEATH_SMOKE.instantiate()
		new_smoke.global_position = $Slime.global_position
		get_parent().add_child(new_smoke)
		queue_free()
		
		

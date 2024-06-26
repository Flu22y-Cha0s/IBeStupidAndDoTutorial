extends Area2D

@onready var crosshair = get_node("/root/Game/MouseCrosshair")

var multi_shot = false
var fast_shot = false

var multi_shot_amount = 3
var shot_delay = 0.6

var flipped = false

func _ready():
	$Weapon_Pivot/Pistol/MuzzleFlash.visible = false
	$Timer.wait_time = shot_delay

func _physics_process(delta):

	$Weapon_Pivot.look_at(get_global_mouse_position())
	
	if $Weapon_Pivot.rotation_degrees > 360:
		$Weapon_Pivot.rotation_degrees -= 360
		
	if $Weapon_Pivot.rotation_degrees < 0:
		$Weapon_Pivot.rotation_degrees += 360
		
	if $Weapon_Pivot.rotation_degrees > 90 && $Weapon_Pivot.rotation_degrees < 270:
		if flipped == false:
			$Weapon_Pivot/Pistol/AnimationPlayerGunTransformations.play("Flip")
			
		flipped = true
		##$Weapon_Pivot/Pistol.flip_v = true
		
	else:
		if flipped == true:
			$Weapon_Pivot/Pistol/AnimationPlayerGunTransformations.play_backwards("Flip")
		flipped = false
		##$Weapon_Pivot/Pistol.flip_v = false
	
	if Input.is_action_pressed("shoot_control"):
		if $Timer.is_stopped():
			shoot()
			
	
func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	
		
	do_recoil()
	if fast_shot:
		$Timer.wait_time = shot_delay/2
	else:
		$Timer.wait_time = shot_delay
	$Timer.start()
	
	if multi_shot == false:
		new_bullet.global_position = %Shooting_Point.global_position
		new_bullet.global_rotation = %Shooting_Point.global_rotation
		%Shooting_Point.add_child(new_bullet)
		new_bullet.appear_animation()
	
	if multi_shot:
		var i = 0
		
		if multi_shot_amount%2 == 1:
			while i < multi_shot_amount:
				new_bullet = BULLET.instantiate()
				new_bullet.global_position = %Shooting_Point.global_position
				new_bullet.global_rotation = %Shooting_Point.global_rotation -(0.3*(multi_shot_amount/2)) + (0.3*i)
				%Shooting_Point.add_child(new_bullet)
				new_bullet.appear_animation()
				i += 1
				
		if multi_shot_amount%2 == 0:
			while i < multi_shot_amount:
				new_bullet = BULLET.instantiate()
				new_bullet.global_position = %Shooting_Point.global_position
				new_bullet.global_rotation = %Shooting_Point.global_rotation -(0.3/2) - (((multi_shot_amount/2)-1)*0.3) + (0.3*i)
				%Shooting_Point.add_child(new_bullet)
				new_bullet.appear_animation()
				i += 1
		
		
func do_recoil():
	crosshair.play_anim()
	
	if fast_shot:
		$AnimationPlayerRecoil.speed_scale = 2
		
		
		
		
		if flipped == false:
			$AnimationPlayerRecoil.play("recoil")
		if flipped == true:
			$AnimationPlayerRecoil.play("recoil_reverse")
	else:
		$AnimationPlayerRecoil.speed_scale = 1
		
		
		
		
		if flipped == false:
			$AnimationPlayerRecoil.play("recoil")
		if flipped == true:
			$AnimationPlayerRecoil.play("recoil_reverse")
	




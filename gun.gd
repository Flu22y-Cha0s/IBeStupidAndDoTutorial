extends Area2D



var multi_shot = false
var fast_shot = false

var multi_shot_amount = 3
var shot_delay = 0.6

var flipped = false

func _ready():
	$Timer.wait_time = shot_delay

func _physics_process(delta):
	$Weapon_Pivot.look_at(get_global_mouse_position())
	
	## var Enemies_In_Range = get_overlapping_bodies()
	## if Enemies_In_Range.size() > 0:
	## 	var Target_Enemy = Enemies_In_Range.front()
	## 	$Weapon_Pivot.look_at(Target_Enemy.global_position)
		
		
	
	
	if $Weapon_Pivot.rotation_degrees > 360:
		$Weapon_Pivot.rotation_degrees -= 360
		
	if $Weapon_Pivot.rotation_degrees < 0:
		$Weapon_Pivot.rotation_degrees += 360
		
	if $Weapon_Pivot.rotation_degrees > 90 && $Weapon_Pivot.rotation_degrees < 270:
		if flipped == false:
			$Weapon_Pivot/Pistol/AnimationPlayerFlip.play("Flip")
			
		flipped = true
		##$Weapon_Pivot/Pistol.flip_v = true
		
	else:
		if flipped == true:
			$Weapon_Pivot/Pistol/AnimationPlayerFlip.play_backwards("Flip")
		flipped = false
		##$Weapon_Pivot/Pistol.flip_v = false
		

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	if multi_shot == false:
		new_bullet.global_position = %Shooting_Point.global_position
		new_bullet.global_rotation = %Shooting_Point.global_rotation
		%Shooting_Point.add_child(new_bullet)
	
	if multi_shot:
		var i = 0
		
		if multi_shot_amount%2 == 1:
			while i < multi_shot_amount:
				new_bullet = BULLET.instantiate()
				new_bullet.global_position = %Shooting_Point.global_position
				new_bullet.global_rotation = %Shooting_Point.global_rotation -(0.3*(multi_shot_amount/2)) + (0.3*i)
				%Shooting_Point.add_child(new_bullet)
				i += 1
				
		if multi_shot_amount%2 == 0:
			while i < multi_shot_amount:
				new_bullet = BULLET.instantiate()
				new_bullet.global_position = %Shooting_Point.global_position
				new_bullet.global_rotation = %Shooting_Point.global_rotation -(0.3/2) - (((multi_shot_amount/2)-1)*0.3) + (0.3*i)
				%Shooting_Point.add_child(new_bullet)
				i += 1
		
		

	
	

func _on_timer_timeout():
	##var Enemies_In_Range = get_overlapping_bodies()
	##if Enemies_In_Range.size() > 0: 
	shoot()
	if fast_shot:
		$AnimationPlayer.play("recoil_fast")
	else:
		$AnimationPlayer.play("recoil_long")
			
	if fast_shot:
		$Timer.wait_time = shot_delay/2
	else:
		$Timer.wait_time = shot_delay
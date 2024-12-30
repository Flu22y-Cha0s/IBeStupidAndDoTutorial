extends Node2D


func play_walk():
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")

func color(rgb_value):
	$Anchor.modulate = rgb_value

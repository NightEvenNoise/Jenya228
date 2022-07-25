extends Node

func _physics_process(_delta):
	if !$AnimationPlayer.is_playing():
		get_tree().change_scene("res://jenya/MissionKillUniters.tscn")

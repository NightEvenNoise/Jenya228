extends Node2D

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Title.tscn")

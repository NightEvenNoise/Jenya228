extends Node

func _input(_event):
	if Input.is_action_pressed("reload"):
		get_tree().call_deferred("reload_current_scene")
	if Input.is_action_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene", "res://Menu.tscn")

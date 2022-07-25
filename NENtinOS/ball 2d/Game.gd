extends Node2D

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://NENtinOS/Main.tscn")

func _physics_process(_delta) -> void:
	$Camera2D.position = $Ball.position + Vector2(0,-80)

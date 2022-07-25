extends Control

func _process(_delta) -> void:
	if $button.pressed && $password.text == "":
		get_tree().call_deferred("change_scene","res://NentinOS/LoadOS.tscn")

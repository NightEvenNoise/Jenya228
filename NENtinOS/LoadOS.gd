extends Control

func _process(_delta) -> void:
	if $logo.rect_position.y != 100:
		$logo.rect_position.y += 0.5
	if $progress_bar.value == 100:
		get_tree().call_deferred("change_scene","res://NENtinOS/Main.tscn")

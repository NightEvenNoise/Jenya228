extends WindowDialog

func _process(_delta) -> void:
	if $LineEdit.text == "Google":
		if Input.is_action_just_pressed("enter") || $Button.pressed:
			$LineEdit.text = "Hello!"
	if visible:
		if $LineEdit.text == "":
			if Input.is_action_just_pressed("enter") || $Button.pressed:
				OS.alert("stop", "Alert")
	if $LineEdit.text == "pmgp":
		if Input.is_action_just_pressed("enter") || $Button.pressed:
			get_tree().change_scene("res://pmgp.tscn")

extends Control

func _on_Button_toggled(button_pressed):
	if button_pressed:
		$AudioStreamPlayer2.play()
		$AudioStreamPlayer.stop()
		$TextureRect.hide()
		$ColorRect.show()
	else:
		$AudioStreamPlayer.play()
		$AudioStreamPlayer2.stop()
		$TextureRect.show()
		$ColorRect.hide()

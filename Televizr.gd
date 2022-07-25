extends Spatial

const MOUSE_SENS = 0.2

func _process(_delta) -> void:
	if !$VideoPlayer.is_playing():
		get_tree().change_scene("res://jenya/Game.tscn")

func _physics_process(_delta) -> void:
	$VideoPlayer.volume_db = -$Television_01/RootNode/Cylinder003_low.rotation.z

func _input(event):
	if Input.is_action_pressed("lmb"):
		if event is InputEventMouseMotion || event is InputEventScreenDrag:
			$Television_01/RootNode/Cylinder003_low.rotation_degrees.z -= MOUSE_SENS * event.relative.x

extends Node

func _ready():
	$Jenya/AnimationPlayer.play("cheering_narkoman")

func _physics_process(_delta) -> void:
	$"2D/Camera2D".position = $"2D/RigidVehicle".position
	$"2D/TouchScreenButton".position = $"2D/Camera2D".position + Vector2(250,130)
	$"2D/TouchScreenButton2".position = $"2D/Camera2D".position - Vector2(250,-300)
	$"2D/Button".rect_position = $"2D/Camera2D".position - Vector2(510,300)
	if $"2D/Button".pressed:
		get_tree().change_scene("res://NENtinOS/Main.tscn")

func _input(_event) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_fall_body_entered(body):
	if body.name == "RigidVehicle":
		get_tree().reload_current_scene()

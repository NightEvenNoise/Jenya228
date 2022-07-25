extends Node

func _ready():
	if !g.mobile_buttons:
		$ControlAndroid.hide()
	$"3D/Jenya228/Jenya/Skeleton/BoneAttachment2/Horror Clown mask".show()

func _physics_process(_delta):
	$"3D/Camera".look_at($"3D/Jenya228".translation,Vector3.UP)
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")

func _on_ChangeScene_body_entered(body):
	if body.name == "Jenya228":
		get_tree().change_scene("res://hitler/HitlerRap.tscn")

extends Spatial

func _ready():
	$hitler_full/RootNode/AnimationPlayer.play("rap")
	$Anchovy/RootNode/AnimationPlayer.play("dance")

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://shrek/boloto.tscn")

func _on_AudioStreamPlayer_finished():
	get_tree().change_scene("res://shrek/boloto.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://shrek/boloto.tscn")

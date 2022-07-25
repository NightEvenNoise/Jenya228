extends Spatial

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(_delta):
	if $Shrek.transform.origin.distance_to($hitler_full.transform.origin) < 2:
		get_tree().change_scene("res://shrek/shrekumer.tscn")

func _input(_event):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")

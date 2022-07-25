extends RigidBody2D

var speed = 15

func _physics_process(_delta) -> void:
	if Input.is_action_pressed("ui_left"):
		angular_velocity = -speed
	if Input.is_action_pressed("ui_right"):
		angular_velocity = speed

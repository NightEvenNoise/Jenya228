extends RigidBody2D

var speed = 100

func _physics_process(_delta) -> void:
	if Input.is_action_pressed("ui_up"):
		$PinJoint2D/RigidBody2D.angular_velocity = speed
		$PinJoint2D2/RigidBody2D.angular_velocity = speed
	if Input.is_action_pressed("ui_down"):
		$PinJoint2D/RigidBody2D.angular_velocity = -speed
		$PinJoint2D2/RigidBody2D.angular_velocity = -speed

extends RigidBody2D

var speed = 1000

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		move_local_x(speed * delta)
		$DampedSpringJoint2D/RigidBody2D.rotation += speed * delta
		$DampedSpringJoint2D2/RigidBody2D.rotation += speed * delta
	if Input.is_action_pressed("ui_down"):
		move_local_x(-speed * delta)
		$DampedSpringJoint2D/RigidBody2D.rotation -= speed * delta
		$DampedSpringJoint2D2/RigidBody2D.rotation -= speed * delta
	if Input.is_action_pressed("ui_left"):
		rotate(-0.1)
	if Input.is_action_pressed("ui_right"):
		rotate(0.1)

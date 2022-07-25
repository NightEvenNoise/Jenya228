extends KinematicBody

var timer = 0

func _physics_process(delta):
	timer += delta
	if timer > 5:
		return queue_free()
	var cld = move_and_collide(transform.basis.z * 5)
	if  cld && cld.collider_id:
		if cld.collider.has_method('on_bullet'):
			cld.collider.call('on_bullet')
		queue_free()

extends KinematicBody

var vel_speed = 15
const ROT_SPEED = 0.01
const GR_SPEED = 0.5
const RUN_SPEED = 4

var block_control = false
var vel = Vector3()

func _physics_process(_delta: float) -> void:
	var dir = Vector3()
	var rot = 0
	
	if !block_control:
		if Input.is_action_pressed('ui_right'):
			rot = -1
		elif Input.is_action_pressed('ui_left'):
			rot = 1
		if $Timer.is_stopped():
			dir.z = -1
			$Timer.start(0)
		look_at(get_parent().get_node("Jenya").translation,Vector3.UP)

	if rot:
		rotate_y(rot * ROT_SPEED)

	if dir:
		dir = dir.rotated(Vector3.UP, rotation.y) * vel_speed

	vel.z = dir.z
	vel.x = dir.x

	if !is_on_floor():
		vel.y -= GR_SPEED

	vel = move_and_slide(vel, Vector3.UP)

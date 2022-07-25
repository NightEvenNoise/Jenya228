extends KinematicBody

export var head_path: NodePath
export var cam_path: NodePath
onready var head: Spatial = get_node(head_path)
onready var cam: Camera = get_node(cam_path)
var mouse_axis := Vector2()
export var mouse_sensitivity := 10.0

var VEL_SPEED = 1
const ROT_SPEED = 0.01
const GR_SPEED = 0.5
const RUN_SPEED = 4

onready var anim = $Jenya/AnimationPlayer
var block_control = false
var vel = Vector3()
var state = 'drunk_idle'
var need_state = ''
var srat = false
var skolzko = false

func _ready():
	mouse_sensitivity = g.sensetivity
	$Jenya/Skeleton/BoneAttachment/Camera.current = true
	if g.irongay:
		$IronGay.show()
		$Jenya.hide()
		anim = $IronGay/RootNode/AnimationPlayer
		VEL_SPEED = 2

func _process(_delta: float) -> void:
	camera_rotation()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag || event is InputEventMouseMotion:
		mouse_axis = event.relative

func _physics_process(_delta: float) -> void:
	var dir = Vector3()
	var rot = 0
	#var need_state = ''
	need_state = ''
	var need_anim = ''
	
	if anim.current_animation != 'uppercut' && !block_control: #&& anim.current_animation != 'injuredjump':
		if Input.is_action_pressed('ui_right'):
			rot = -1
		elif Input.is_action_pressed('ui_left'):
			rot = 1

		if Input.is_action_pressed('ui_up'):
			dir.z = 1
			if Input.is_action_just_pressed("ui_jump"):
				if g.irongay:
					anim.play("injuredjump")
					vel.y += 10
			if anim.current_animation != 'injuredjump' && anim.current_animation != 'drunk_run' && anim.current_animation != 'inmovejump':
				anim.play("drunk_walk")
			if Input.is_action_pressed('ui_shift'):
				dir.z = RUN_SPEED
				if Input.is_action_just_pressed("ui_jump") && !g.irongay && is_on_floor():
					anim.play("inmovejump")
				elif anim.current_animation != 'inmovejump':
					anim.play("drunk_run")
		elif Input.is_action_pressed('ui_down'):
			dir.z = -1
		if Input.is_action_just_pressed('ui_attack') && OS.get_name() == "Android":
			need_state = 'uppercut'
		if Input.is_action_just_pressed('lmb') && OS.get_name() != "Android":
			need_state = 'uppercut'
		if Input.is_action_just_pressed("ui_jump"):
			if is_on_floor() || g.irongay:
				need_state = 'injuredjump'
				vel.y += 10
	if Input.is_action_just_pressed("cam_chng"):
		$head/Camera.current = not $head/Camera.current
	if srat:
		need_state = 'sitting_laughing'
	if skolzko:
		need_state = 'skolzko'

	if rot:
		rotate_y(rot * ROT_SPEED)
		need_state = 'drunk_walk'

	if dir:
		need_state = 'drunk_run' if dir.z == RUN_SPEED else 'drunk_walk'
		dir = dir.rotated(Vector3.UP, rotation.y) * VEL_SPEED

	vel.z = dir.z
	vel.x = dir.x

	if !is_on_floor():
		vel.y -= GR_SPEED

	vel = move_and_slide(vel, Vector3.UP)
	if anim.current_animation != 'uppercut' && anim.current_animation != 'injuredjump':
		if !need_state: need_state = 'drunk_idle'
	set_state(need_state, need_anim)

func set_state(s, a=''):
	if !s || state == s: return
	state = s
	if !a: a = s 
	if anim.current_animation == a: return
	if a == 'drunk_run': anim.playback_speed = 1
	else: anim.playback_speed = 1
	anim.play(a, 0.3)

func camera_rotation() -> void:
	if mouse_axis.length() > 0 && !block_control:
		var _smoothness := 80
		var horizontal: float = -(mouse_axis.x * mouse_sensitivity) / _smoothness
		var vertical: float = (mouse_axis.y * mouse_sensitivity) / _smoothness
		mouse_axis = Vector2()
		rotate_y(deg2rad(horizontal))
		head.rotate_x(deg2rad(vertical))
		var temp_rot: Vector3 = head.rotation_degrees
		temp_rot.x = clamp(temp_rot.x, -90, 90)
		head.rotation_degrees = temp_rot

extends Node

var hvatit_srat = false
var hvatit_padat = false
var camera
var carh = false
var incar = false

func _ready():
	if g.optimization:
		$Spatial/DirectionalLight.directional_shadow_mode = DirectionalLight.SHADOW_ORTHOGONAL
		$Spatial/DirectionalLight.directional_shadow_depth_range = DirectionalLight.SHADOW_DEPTH_RANGE_OPTIMIZED
	if OS.get_name() != "Android":
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if !g.mobile_buttons:
		$ControlAndroid.hide()
	$Spatial/Jenya.block_control = true
	$Spatial/Jenya.need_state = "sitting_laughing"
	if g.shadows:
		$Spatial/DirectionalLight.shadow_enabled = true

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("ui_attack") || g.irongay:
		$Srat.stop()
	if $Srat.is_stopped() && !hvatit_srat:
		$Spatial/Jenya.block_control = false
		$Spatial/Jenya.need_state = ''
		#$Spatial/Cam_srat.current = false
		#$Spatial/Jenya/head/Camera.current = true
		#$Spatial/Cam_srat.hide()
		$Spatial/Jenya/FartAudio.stop()
		$Spatial/Jenya.translate(Vector3(0,0,1))
		hvatit_srat = true
		$Spatial/Jenya.srat = false
	if !hvatit_srat:
		$Spatial/Jenya.srat = true
	if carh:
		$Spatial/Jenya.block_control = true
		$Spatial/Jenya/Jenya/AnimationPlayer.play("incarjump")
		$Spatial/Jenya/head/Camera.current = false
		$Spatial/VehicleBody/Camera.current = true
		$ControlAndroid/left.hide()
		$ControlAndroid/right.hide()
		$ControlAndroid/rightup.hide()
		$ControlAndroid/leftcar.show()
		$ControlAndroid/rightcar.show()
		$Spatial/Jenya/CollisionShape.disabled = true
		$Spatial/Jenya.translation = $Spatial/VehicleBody.translation
	if Input.is_action_just_pressed("ui_attack") && carh:
		carh = false
		incar = true
	if !carh && hvatit_srat && incar:
		$Spatial/Jenya/CollisionShape.disabled = false
		$Spatial/Jenya.block_control = false
		$Spatial/Jenya/Jenya/AnimationPlayer.play("drunk_idle")
		$Spatial/Jenya/head/Camera.current = true
		$Spatial/VehicleBody/Camera.current = false
		incar = false
		$ControlAndroid/left.show()
		$ControlAndroid/right.show()
		$ControlAndroid/leftcar.hide()
		$ControlAndroid/rightcar.hide()
		$ControlAndroid/rightup.show()
	if hvatit_padat:
		#$Spatial/KinematicBody2.translation += Vector3(0,0,0.05)
		$Spatial/KinematicBody2.ehat = true
		$Spatial/KinematicBody2.look_at($Spatial/hitler.translation,Vector3.UP)
	if $Spatial/KinematicBody2.translation == Vector3(4.635492,-0.893444, 25.881495):
		g.create("res://bullet/bullet.tscn", $Spatial/KinematicBody2/PositionBullet.global_transform)
	fix_camera()

func _on_Area_skolzko_body_entered(body):
	if body.name == "Jenya" && !hvatit_padat:
		$AchievementSystem.emit_signal("showAchievement",0)
		$Spatial/hitler.show()
		$Spatial/hitler/AudioStreamPlayer3D.play()
		$"Spatial/Spatial/Non skelet/Skeleton".physical_bones_start_simulation()
		#$Spatial/Spatial/multiband_radio/AudioStreamPlayer3D.play()
		$AudioStreamPlayer.stop()
		#$Spatial/Jenya.block_control = true
		$Spatial/Jenya.skolzko = true
		hvatit_padat = true
		#$Spatial/Spatial/multiband_radio/AudioStreamPlayer3D.stop()
		$"Spatial/Spatial/Non skelet/GdeDengi".play()
		$Spatial/KinematicBody2.look_at($Spatial/hitler.translation,Vector3.UP)

func _on_Area_Notebook_body_entered(body):
	if body.name == "Jenya":
		get_tree().change_scene("res://NENtinOS/LoadOS.tscn")

func _on_Area_skolzko_body_exited(body):
	if body.name == "Jenya":
		$Spatial/Jenya.skolzko = false

func _on_Interier_body_entered(body):
	if body.name == "Jenya":
		get_tree().change_scene("res://interier.tscn")

func _on_InCarOld_body_entered(body):
	if body.name == "Jenya":
		carh = true

func _on_AudioStreamPlayer3D_finished():
	$Spatial/Spatial/multiband_radio/AudioStreamPlayer3D.play()
	if !g.shrekumer:
		get_tree().change_scene("res://jenya/CutScene.tscn")

func fix_camera():
	if $Spatial/Jenya/head/Camera.current:
		$Spatial/Jenya/Jenya/Skeleton/BoneAttachment/Camera.current = false
	if !$Spatial/Jenya/head/Camera.current && !carh:
		$Spatial/Jenya/Jenya/Skeleton/BoneAttachment/Camera.current = true
	if carh:
		$Spatial/Jenya/Jenya/Skeleton/BoneAttachment/Camera.current = false

func _on_IronGayArea_body_entered(body):
	if body.name == "Jenya":
		get_tree().change_scene("res://jenya/irongay/IronPick.tscn")

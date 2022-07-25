extends Node

var hvatit_srat = false
var hvatit_padat = false
var camera
var carh = false
var incar = false

func _ready():
	if g.network_game:
		_connected()
	$Spatial/Jenya/Jenya/Skeleton/BoneAttachment/Camera.queue_free()
	if g.shadows:
		$Spatial/DirectionalLight.shadow_enabled = true
	$Spatial/VehicleBody/Camera.queue_free()

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().call_deferred("change_scene","res://Menu.tscn")

func _physics_process(_delta) -> void:
	if $Srat.is_stopped() && !hvatit_srat:
		$Spatial/Jenya/FartAudio.stop()
		$Spatial/Jenya.translate(Vector3(0,0,1))
		hvatit_srat = true
		$Spatial/Jenya.srat = false
	if !hvatit_srat:
		$Spatial/Jenya.srat = true
	if carh:
		#$Spatial/Jenya.block_control = true
		#$Spatial/Jenya/Jenya/AnimationPlayer.play("incarjump")
		#$Spatial/Jenya/head/Camera.current = false
		#$Spatial/VehicleBody/Camera.current = true
		pass
	if Input.is_action_just_pressed("ui_attack") && carh:
		#carh = false
		#incar = true
		pass
	if !carh && hvatit_srat && incar:
		pass
		#$Spatial/Jenya.block_control = false
		#$Spatial/Jenya/Jenya/AnimationPlayer.play("drunk_idle")
		#$Spatial/Jenya/head/Camera.current = true
		#$Spatial/VehicleBody/Camera.current = false
		#incar = false
	if hvatit_padat:
		$Spatial/KinematicBody2.translation += Vector3(0,0,0.05)
		$Spatial/KinematicBody2.look_at($Spatial/Jenya.translation,Vector3.UP)

func _on_Area_skolzko_body_entered(body):
	if body.name == "Jenya" && !hvatit_padat:
		$Spatial/Spatial/multiband_radio/AudioStreamPlayer3D.play()
		$AudioStreamPlayer.stop()
		#$Spatial/Jenya.block_control = true
		$Spatial/Jenya.skolzko = true
		hvatit_padat = true
		#$Spatial/Spatial/multiband_radio/AudioStreamPlayer3D.stop()
		$"Spatial/Spatial/Non skelet/GdeDengi".play()
		$Spatial/KinematicBody2.look_at($Spatial/Jenya.translation,Vector3.UP)

func _on_Area_Notebook_body_entered(body):
	if body.name == "Jenya" || body.name == "RussianMafia":
		#get_tree().change_scene("res://NENtinOS/LoadOS.tscn")
		OS.alert("Нельзя ноутбук, ты же гуляешь с другом, творюга", "ЭЙ!!!")

func _on_Area_skolzko_body_exited(body):
	if body.name == "Jenya":
		$Spatial/Jenya.skolzko = false

func _connected():
	if get_tree().is_network_server():
		#If in the server, get control of player 2 to the other peer.
		#This function is tree recursive by default.
		get_node("Spatial/Jenya").set_network_master(get_tree().get_network_connected_peers()[0])
		camera = get_node("Spatial/Jenya/head/Camera")
		camera.set_current(true)
		$Spatial/RussianMafia/head/Camera.queue_free()
		$Spatial/RussianMafia.block_control = true
		$Spatial/Jenya.block_control = false
	if g.network_type == "server":
		get_node("Spatial/Jenya").set_network_master(get_tree().get_network_connected_peers()[0])
		camera = get_node("Spatial/Jenya/head/Camera")
		camera.set_current(true)
		$Spatial/RussianMafia/head/Camera.queue_free()
		$Spatial/RussianMafia.block_control = true
		$Spatial/Jenya.block_control = false
	if !get_tree().is_network_server():
		#If in the client, give control of player 2 to itself. 
		#This function is tree recursive by default.
		get_node("Spatial/RussianMafia").set_network_master(get_tree().get_network_unique_id())
		camera = get_node("Spatial/RussianMafia/head/Camera")
		camera.set_current(true)
		$Spatial/Jenya/head/Camera.queue_free()
		$Spatial/RussianMafia.block_control = false
		$Spatial/Jenya.block_control = true
	if g.network_type == "client":
		get_node("Spatial/RussianMafia").set_network_master(get_tree().get_network_unique_id())
		camera = get_node("Spatial/RussianMafia/head/Camera")
		camera.set_current(true)
		$Spatial/Jenya/head/Camera.queue_free()
		$Spatial/RussianMafia.block_control = false
		$Spatial/Jenya.block_control = true

func _on_Interier_body_entered(body):
	if body.name == "Jenya" || body.name == "RussianMafia":
		#get_tree().change_scene("res://interier.tscn")
		OS.alert("Нельзя в квартиру, тебя друг на улице ждёт, творюга", "ЭЙ!!!")

func _on_InCarOld_body_entered(body):
	if body.name == "Jenya":
		carh = true

func _on_DornanTrigger_body_entered(body):
	if body.name == "Jenya" or body.name == "RussianMafia":
		$Spatial/SergDornan/AudioStreamPlayer3D.play()
		$AudioStreamPlayer.stop()

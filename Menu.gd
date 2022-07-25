extends Node

const MOUSE_SENS = -0.2
var color1 = 0
var ip = "127.0.0.1"

func _ready():
	g.irongay = false
	#Parrot.play(preload("res://dialogs/hardbass.tres"))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Spatial/Jenya/AnimationPlayer.play("cheering_narkoman")
	$Spatial/hitler_full/RootNode/AnimationPlayer.play("rap")
	$Spatial/louchador_geo/RootNode/AnimationPlayer.play("dance")
	if OS.get_name() == "Android":
		$Multiplayer/Control/Control/LineEdit.text = '192.168.1.63'
	$Settings/Control/MenuButton.get_popup().connect("id_pressed",self,"on_item_pressed")
	get_tree().connect("network_peer_connected",self,"_connected")
	$Spatial/Polnareff/RootNode/AnimationPlayer.play("dance")

func _process(_delta) -> void:
	if $Control/Button2.pressed:
		$Settings.show()
	if $Control/Button.pressed:
		$WindowDialog.show()
	if $WindowDialog/Control/Button.pressed:
		get_tree().change_scene("res://Intro.tscn")
	if $WindowDialog/Control/Button2.pressed:
		$Multiplayer.show()
	if $Multiplayer/Control/Control/LineEdit.text != '':
		ip = $Multiplayer/Control/Control/LineEdit.text
	if $Multiplayer/Control/Control/LineEdit.text == '':
		ip = "127.0.0.1"

func _physics_process(_delta) -> void:
	text_colors()
	$Spatial/Spatial/MeshInstance2.rotate_y(1)

func on_item_pressed(id):
	var item_name = $Settings/Control/MenuButton.get_popup().get_item_text(id)
	match item_name:
		"Disabled":
			get_viewport().msaa = Viewport.MSAA_DISABLED
		"2X":
			get_viewport().msaa = Viewport.MSAA_2X
		"4X":
			get_viewport().msaa = Viewport.MSAA_4X
		"8X":
			get_viewport().msaa = Viewport.MSAA_8X
		"16X":
			get_viewport().msaa = Viewport.MSAA_16X

func _input(event):
	if Input.is_action_pressed("lmb"):
		if event is InputEventMouseMotion || event is InputEventScreenDrag:
			$Spatial/Jenya.rotation_degrees.y -= MOUSE_SENS * event.relative.x

func text_colors():
	if $Timer.is_stopped() && color1 == 0:
		$Control/Label.add_color_override("font_color",Color(255,0,0))
		$WorldEnvironment.environment.ambient_light_color = Color(255,0,0)
		$Control/Button.add_color_override("font_color",Color(255,0,0))
		$Control/Button2.add_color_override("font_color",Color(255,0,0))
		$Control/Button3.add_color_override("font_color",Color(255,0,0))
		$Timer.start(0)
		color1 = 1
	if $Timer.is_stopped() && color1 == 1:
		$Control/Label.add_color_override("font_color",Color(0,255,0))
		$WorldEnvironment.environment.ambient_light_color = Color(0,255,0)
		$Control/Button.add_color_override("font_color",Color(0,255,0))
		$Control/Button2.add_color_override("font_color",Color(0,255,0))
		$Control/Button3.add_color_override("font_color",Color(0,255,0))
		$Timer.start(0)
		color1 = 2
	if $Timer.is_stopped() && color1 == 2:
		$Control/Label.add_color_override("font_color",Color(0,0,255))
		$WorldEnvironment.environment.ambient_light_color = Color(0,0,255)
		$Control/Button.add_color_override("font_color",Color(0,0,255))
		$Control/Button2.add_color_override("font_color",Color(0,0,255))
		$Control/Button3.add_color_override("font_color",Color(0,0,255))
		$Timer.start(0)
		color1 = 3
	if $Timer.is_stopped() && color1 == 3:
		$Control/Label.add_color_override("font_color",Color(255,255,255))
		$WorldEnvironment.environment.ambient_light_color = Color(0,0,0)
		$Control/Button.add_color_override("font_color",Color(255,255,255))
		$Control/Button2.add_color_override("font_color",Color(255,255,255))
		$Control/Button3.add_color_override("font_color",Color(255,255,255))
		$Timer.start(0)
		color1 = 0

func _on_Server_pressed():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(8080,2)
	get_tree().set_network_peer(server)
	g.network_type = "server"

func _on_Client_pressed():
	var client = NetworkedMultiplayerENet.new()
	client.create_client(ip,8080)
	get_tree().set_network_peer(client)
	g.network_type = "client"

func _connected(_client_id) -> void:
	g.network_game = true
	get_tree().change_scene("res://jenya/GameMultiplayer.tscn")

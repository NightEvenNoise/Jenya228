extends Control

var chpassword = false
var jjeye = false
onready var console_line = $Console/LineEdit
onready var mobile_enter = $Console/LineEdit/EnterButton
var ball2d = false
var ORRCar = false
var pong = false
var cfmg = false
var color_bg = 232872

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"Custom theme/FileDialog".get_ok().connect("pressed",self,"open_bg_img")

func _process(_delta) -> void:
	color_bg = $"Custom theme/ColorBackgroundButton".color
	$Background.color = Color(color_bg)
	if $Position_paint/paint.pressed:
		$Paint.show()
	if $Position2D/Panel2/TDocument.pressed:
		pass
	if $"Menu/customa thema".pressed:
		$"Custom theme".show()
	if $Panel/ConsoleButton.pressed:
		$Console.show()
	if $"Custom theme/CstomImgButton".pressed:
		$"Custom image".show()
	if $Panel/GoogleButton.pressed:
		$Google.show()
	if $Menu/settings.pressed:
		$Pssword.show()
	if $Position_Ball2D/Ball2D_b.pressed:
		$StartProgram/AnimationPlayer.play("Start")
		ball2d = true
	if ball2d && !$StartProgram/AnimationPlayer.is_playing():
		get_tree().call_deferred("change_scene","res://NENtinOS/ball 2d/Game.tscn")
	if $Pssword.text == "" && $Pssword/Button.pressed:
		pass
	if $Pssword.text != "" && $Pssword/Button.pressed:
		OS.alert("Неправильный пароль","Предупреждение")
		$Pssword.hide()
	if $Panel/FolderButton.pressed:
		$Explorer.show()
	if $Position_OffRoadRacing/OffRoadRacing_b.pressed:
		$StartProgram/AnimationPlayer.play("Start")
		ORRCar = true
	if ORRCar && !$StartProgram/AnimationPlayer.is_playing():
		get_tree().call_deferred("change_scene","res://NENtinOS/off road racing/game.tscn")
	if $Position_cfmg/cfmg.pressed:
		$StartProgram/AnimationPlayer.play("Start")
		cfmg = true
	if cfmg && !$StartProgram/AnimationPlayer.is_playing():
		get_tree().call_deferred("change_scene","res://NENtinOS/cyberflexmoto/Menu.tscn")
	if $Position_pong/pong_b.pressed:
		$StartProgram/AnimationPlayer.play("Start")
		pong = true
	if pong && !$StartProgram/AnimationPlayer.is_playing():
		get_tree().call_deferred("change_scene","res://NENtinOS/pong/pong.tscn")
	console_commands()
	nenpac()
	OS_commands()
	cstm_wallpaper()
	if $jjeye/Timer.is_stopped() && jjeye:
		get_tree().quit()
	if $Console/LineEdit.text == "":
		$Console/LineEdit/EnterButton.hide()
	if $Console/LineEdit.text != "":
		$Console/LineEdit/EnterButton.show()

func console_commands():
	if console_line.text == "paint": 
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			$Paint.show()
			$Console.hide()
	if console_line.text == "jj.eye": 
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			$Console.hide()
			$jjeye.show()
			$jjeye.play()
			$jjeye/Timer.start()
			jjeye = true
	if console_line.text == "clear all": 
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			$Console/TextEdit.text = ""
			console_line.text = ""
	if console_line.text == "rcg":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = "starting..."
			get_tree().call_deferred("change_scene","res://NENtinOS/perfectgirlcity/Title.tscn")
	if console_line.text == "3dbg":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			$Background.hide()
			$TextureBG.hide()

func OS_commands():
	if console_line.text == "OS.quit":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			get_tree().quit()
	if console_line.text == "OS.sys":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = OS.get_name()
	if console_line.text == "OS.size":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = "window size" + str(OS.window_size)
	if console_line.text == "OS.date":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_date())
	if console_line.text == "OS.time":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_time())
	if console_line.text == "OS.audio_driver":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_audio_driver_name(1))
	if console_line.text == "OS.video_driver":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_video_driver_name(1))
	if console_line.text == "OS.power_state":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_power_state())
	if console_line.text == "OS.process_id":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_process_id())
	if console_line.text == "OS.language":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = TranslationServer.get_locale()
	if console_line.text == "OS.unique_id":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_unique_id())
	if console_line.text == "OS.model_name":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_model_name())
	if console_line.text == "OS.memory_usage":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_dynamic_memory_usage())
	if console_line.text == "OS.videocard":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(VisualServer.get_video_adapter_name())
	if console_line.text == "OS.kill":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = "kill"
			OS.call_deferred("kill",OS.get_process_id())
	if console_line.text == "OS.virtual_keyboard_height":
		if Input.is_action_just_pressed("enter") || mobile_enter:
			console_line.text = str(OS.get_virtual_keyboard_height())
	if console_line.text == "OS.low_proc_usage":
		if Input.is_action_just_pressed("enter") || mobile_enter:
			OS.low_processor_usage_mode = true
			console_line.text = "low process usage enabled"
	if console_line.text == "OS.exe_path":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = str(OS.get_executable_path())

func nenpac():
	if console_line.text == "nenpac -sys":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			console_line.text = "updating..."
	if console_line.text == "nenpac -r paint":
		if Input.is_action_just_pressed("enter") || mobile_enter.pressed:
			$Position_paint.hide()

func cstm_wallpaper():
	if $"Custom image/Button".pressed:
		$TextureBG/TextureRect.show()
		$TextureBG/TextureRect2.hide()
		$TextureBG/TextureRect3.hide()
		$TextureBG/TextureRect4.hide()
	if $"Custom image/Button2".pressed:
		$TextureBG/TextureRect.hide()
		$TextureBG/TextureRect2.show()
		$TextureBG/TextureRect3.hide()
		$TextureBG/TextureRect4.hide()
	if $"Custom image/Button3".pressed:
		$TextureBG/TextureRect.hide()
		$TextureBG/TextureRect2.hide()
		$TextureBG/TextureRect3.show()
		$TextureBG/TextureRect4.hide()
	if $"Custom image/Button4".pressed:
		$TextureBG/TextureRect.hide()
		$TextureBG/TextureRect2.hide()
		$TextureBG/TextureRect3.hide()
		$TextureBG/TextureRect4.show()
	if $"Custom image/clear".pressed:
		$TextureBG/TextureRect.hide()
		$TextureBG/TextureRect2.hide()
		$TextureBG/TextureRect3.hide()
		$TextureBG/TextureRect4.hide()

func _on_MenuButton_toggled(button_pressed):
	if button_pressed:
		$Menu.show()
	else:
		$Menu.hide()

func _on_custom_theme_pressed():
	$"Custom theme".show()

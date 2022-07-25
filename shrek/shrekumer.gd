extends Control

var konetz = false

func _ready():
	g.shrekumer = true

func _process(_delta):
	if $Timer.is_stopped() && konetz:
		get_tree().change_scene("res://jenya/Game.tscn")

func _on_AudioStreamPlayer_finished():
	$Timer.start(0)
	konetz = true

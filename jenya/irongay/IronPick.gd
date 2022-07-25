extends Spatial

func _ready():
	g.irongay = true
	$IronGay/RootNode/AnimationPlayer.play("brutal")

func _process(_delta):
	if $Timer.is_stopped():
		$Jenya.translate(Vector3(0,0,0.2))
	if !$IronGay/RootNode/AnimationPlayer.is_playing():
		get_tree().change_scene("res://jenya/Game.tscn")

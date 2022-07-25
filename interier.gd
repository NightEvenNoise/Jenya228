extends Spatial

func _ready():
	var viewport = $CoffeeTable_01/Television_01/Viewport
	$CoffeeTable_01/Television_01/Viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	$QuadMesh.get_surface_material(0).albedo_texture = viewport.get_texture()

func _process(_delta) -> void:
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Menu.tscn")

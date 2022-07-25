extends KinematicBody2D

var vec = Vector2()
var ndeb = true

func _ready():
	animation("idle")

func _physics_process(_delta) -> void:
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		$Shirt.flip_h = false
		$Skirt.flip_h = false
		$White.flip_h = false
		vec.x = 200

	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = true
		$Shirt.flip_h = true
		$Skirt.flip_h = true
		$White.flip_h = true
		vec.x = -200

	if Input.is_action_pressed("ui_attack_rvg"):
		animation("attack3")

	if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right") && $AnimatedSprite.animation != "attack3":
		animation("idle")
		vec.x = 0
	if $AnimatedSprite.animation == "attack3":
		vec.x = 0
	if $AnimatedSprite.frame == 9 && $AnimatedSprite.animation == "attack3":
		animation("idle")

	if Input.is_action_just_pressed("nde"):
		ndeb = not ndeb
	if ndeb:
		_nde(true)
	if !ndeb:
		_nde(false)

	if abs(vec.x) > 0.1:
		animation("walk")

	vec = move_and_slide(vec, Vector2.UP)

func animation(animationc:String):
	$AnimatedSprite.play(animationc)
	$White.play(animationc)
	$Shirt.play(animationc)
	$Skirt.play(animationc)

func _nde(nden:bool):
	$Shirt.visible = nden
	$Skirt.visible = nden
	$White.visible = nden

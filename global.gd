extends Node

var shadows = false
var network_game = false
var network_type = "server"
var mobile_buttons = true
var optimization = false
var shrekumer = false
var sensetivity = 10
var irongay = false
var world
var CREATE_NODES = {}

func create(node_path, gl_transform):
	if !CREATE_NODES.has(node_path):
		CREATE_NODES[node_path] = load(node_path)
	var node = CREATE_NODES[node_path].instance()
	node.global_transform = gl_transform
	world.add_child(node)

func _input(_event):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen

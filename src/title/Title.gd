extends Control

export (PackedScene) var next_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		Game.set_scene(next_scene)
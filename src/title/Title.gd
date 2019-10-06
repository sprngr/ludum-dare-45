extends Control

export (PackedScene) var next_scene

func _ready():
	GameState.reset()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		Game.set_scene(next_scene)
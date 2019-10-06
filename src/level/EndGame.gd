extends Area2D

export (PackedScene) var next_scene

func _physics_process(delta):
	var bodies = self.get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			GameState.update(GameState.ACTIONS.STATUS, GameState.STATUS.SUCCESS)
			self.get_parent().get_parent().get_node('HUD').stopTimerSuccess()

func _input(event):
	if GameState.getState().status == GameState.STATUS.SUCCESS && Input.is_action_just_pressed("ui_accept"):
		Game.set_scene(next_scene)	
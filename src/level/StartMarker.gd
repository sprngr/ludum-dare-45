extends Area2D

func _physics_process(delta):
	var bodies = self.get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			GameState.update(GameState.ACTIONS.STATUS, GameState.STATUS.PLAYING)
			self.get_parent().get_parent().get_node('HUD').startTimer()
			self.queue_free()
extends Area2D

func _physics_process(delta):
	var bodies = self.get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			GameState.update(GameState.ACTIONS.LOOT, 1)

			self.queue_free()
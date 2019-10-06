extends Node

var level_map

func _ready():
	# Hard reset to not cause constant encumbrance
	GameState.state.loot = 0
	GameState.update(GameState.ACTIONS.STATUS, GameState.STATUS.READY)
	
	level_map = load('res://src/map/Level'+ str(GameState.getState().level) + '.tscn').instance()
	
	self.call_deferred("add_child", level_map)
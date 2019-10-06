extends Node

enum ACTIONS {
	LEVEL,
	LOOT,
	SCORE,
	TIME,
	STATUS
	}

enum STATUS {
	READY,
	PLAYING,
	SUCCESS,
	GAMEOVER
	}
	
var base_state = {
	"level": 1,
	"loot": 0,
	"score": 0,
	"time": 0,
	"status": STATUS.READY
	}

var state = {}

func _ready():
	self.reset()

func getState():
	return state

func reset():
	state = base_state
	
func update(action, payload = null):
	match action:
		ACTIONS.LEVEL:
			levelReducer(payload)
		ACTIONS.LOOT:
			lootReducer(payload)
			scoreReducer(payload)
		ACTIONS.TIME:
			timeReducer(payload)
		ACTIONS.STATUS:
			statusReducer(payload)

	return state

func levelReducer(value = 1):
	state.level += value

func lootReducer(value = 1):
	state.loot += value

func scoreReducer(value = 1):
	state.score += value * 10

func statusReducer(value):
	state.status = value

func timeReducer(value):
	state.time = value
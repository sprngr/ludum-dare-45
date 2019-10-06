extends RichTextLabel

const DEFAULT_S = 30

var ms = 9
var s = 0

func startTimer():
	resetTimer()
	$Timer.start()

func stopTimer():
	$Timer.stop()
	
func resetTimer(seconds = DEFAULT_S):
	ms = 9
	s = seconds
	GameState.update(GameState.ACTIONS.TIME, float(str(s) + "." + str(ms)))
	self.set("custom_colors/default_color", "#ffffff")
	
func _process(delta):
	if ms == 0:
		ms = 9
		s -= 1
		
	GameState.update(GameState.ACTIONS.TIME, float(str(s) + "." + str(ms)))
	self.bbcode_text = "[center]" + str(s) + "." + str(ms) + "[/center]"
	
	if s <= 10:
		self.set("custom_colors/default_color", "#ff0000")
	elif s <= 20:
		self.set("custom_colors/default_color", "#ffff00")
	
func _on_Timer_timeout():
	ms -= 1
extends CanvasLayer

func _process(delta):
	if GameState.getState().time <= 0 && GameState.getState().status == GameState.STATUS.PLAYING:
		GameState.update(GameState.ACTIONS.STATUS, GameState.STATUS.GAMEOVER)
		stopTimerGameOver()

func _input(event):
	if GameState.getState().status == GameState.STATUS.GAMEOVER && Input.is_action_just_pressed("ui_accept"):
		var next_scene = ResourceLoader.load('res://src/title/Title.tscn')
		Game.set_scene(next_scene)	
		
func startTimer():
	self.showTimer()
	$TimerLabel.startTimer()
	
func stopTimerSuccess():
	$TimerLabel.stopTimer()
	self.hideTimer()
	self.showSuccess()
	
func stopTimerGameOver():
	$TimerLabel.stopTimer()
	self.hideTimer()
	self.showGameOver()
	
func showTimer():
	$TimerLabel.show()

func hideTimer():
	$TimerLabel.hide()
	
func showGameOver():
	$GameOverLabel/FinalScoreLabel.text = "Final Score: " + str(GameState.getState().score)
	$GameOverLabel.show()
	$RestartLabel.show()

func hideGameOver():
	$GameOverLabel.hide()

func showSuccess():
	$SuccessLabel/ScoreLabel.text = "Score: " + str(GameState.getState().score)
	$SuccessLabel.show()
	$ContinueLabel.show()
	
func hideSuccess():
	$SuccessLabel.hide()
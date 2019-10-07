extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const ACCELERATION = 50
const JUMP_HEIGHT = 500
const MAX_SPEED = 200

const STRENGTH = 15

var motion = Vector2()

func getEncumberedValue(base):
	var loot = GameState.getState().loot
	var encumbranceLevel = clamp(floor(loot / STRENGTH), 0, 3)
	
	if encumbranceLevel == 0:
		$Sprite.texture = load("res://assets/protochar-sheet.png")
	
	if encumbranceLevel == 1:
		base = base - ceil(base / 4)
		$Sprite.texture = load("res://assets/protochar-sheet2.png")
	elif encumbranceLevel == 2:
		base = base - ceil(base / 3)
		$Sprite.texture = load("res://assets/protochar-sheet3.png")
	elif encumbranceLevel == 3:
		base = base - ceil(base / 2.25)
		$Sprite.texture = load("res://assets/protochar-sheet4.png")
	
	return base
	
# warning-ignore:unused_argument
func _physics_process(delta):
	var friction = false
	
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop(false)
				
	if GameState.getState().status <= GameState.STATUS.PLAYING:
	
		motion.y += GRAVITY
		
		if Input.is_action_pressed("ui_right"):
			motion.x =  min(motion.x + getEncumberedValue(ACCELERATION), getEncumberedValue(MAX_SPEED))
			
			$Sprite.flip_h = false
			$Sprite.offset.x = -8
			if !$AnimationPlayer.is_playing():
				$AnimationPlayer.play("Run")
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - getEncumberedValue(ACCELERATION), -getEncumberedValue(MAX_SPEED))
			$Sprite.flip_h = true
			$Sprite.offset.x = 8
			if !$AnimationPlayer.is_playing():
				$AnimationPlayer.play("Run")
		else:
			friction = true
		
		if self.is_on_floor():	
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -getEncumberedValue(JUMP_HEIGHT)
			if friction:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if friction:
				motion.x = lerp(motion.x, 0, 0.05)
	
		motion = move_and_slide(motion, UP)
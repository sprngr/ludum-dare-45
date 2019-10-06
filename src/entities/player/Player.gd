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
	var encumbranceLevel = floor(loot / STRENGTH)

	if encumbranceLevel == 1:
		base = base - ceil(base / 4)
	elif encumbranceLevel == 2:
		base = base - ceil(base / 3)
	elif encumbranceLevel == 3:
		base = base - ceil(base / 2.25)
	
	return base
	
# warning-ignore:unused_argument
func _physics_process(delta):
	var friction = false
	
	if GameState.getState().status <= GameState.STATUS.PLAYING:
	
		motion.y += GRAVITY
		
		if Input.is_action_pressed("ui_right"):
			motion.x =  min(motion.x + getEncumberedValue(ACCELERATION), getEncumberedValue(MAX_SPEED))
			
			$Sprite.flip_h = false
			$Sprite.offset.x = -8
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - getEncumberedValue(ACCELERATION), -getEncumberedValue(MAX_SPEED))
			$Sprite.flip_h = true
			$Sprite.offset.x = 8
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
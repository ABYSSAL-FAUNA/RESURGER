extends KinematicBody2D

export var MAX_SPEED = 50
export var ACCELERATION = 200
var MOTION = Vector2.ZERO
var DIRECTION
var IDLE_STATE : bool

onready var ANIMATION_PLAYER = $CHARACTER/ANIMATION_PLAYER

func _physics_process(delta):
	var AXIS = Vector2.ZERO
	AXIS.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	AXIS.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	AXIS = AXIS.normalized()
	
	if Input.is_action_just_pressed("ui_right"):
		DIRECTION = 1
	elif Input.is_action_just_pressed("ui_left"):
		DIRECTION = -1
	
	if AXIS == Vector2.ZERO:
		IDLE_STATE = true
		apply_friction(ACCELERATION * delta)
	else:
		IDLE_STATE = false
		apply_movement(AXIS * ACCELERATION * delta)
	
	if IDLE_STATE == true:
		if DIRECTION == 1:
			ANIMATION_PLAYER.play("IDLE_RIGHT")
		else:
			ANIMATION_PLAYER.play("IDLE_LEFT")
	else:
		if DIRECTION == 1:
			ANIMATION_PLAYER.play("WALK_RIGHT")
		else:
			ANIMATION_PLAYER.play("WALK_LEFT")
	MOTION = move_and_slide(MOTION)

func apply_friction(AMOUNT):
	if MOTION.length() > AMOUNT:
		MOTION -= MOTION.normalized() * AMOUNT
	else:
		MOTION = Vector2.ZERO

func apply_movement(ACCELERATION):
	MOTION += ACCELERATION
	MOTION = MOTION.clamped(MAX_SPEED)

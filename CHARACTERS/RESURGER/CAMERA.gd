extends Position2D

onready var PLAYER = get_node("..")

func _physics_process(delta):
	var TARGET = PLAYER.global_position
	var TARGET_POS_X = float(lerp(global_position.x, TARGET.x, 0.2))
	var TARGET_POS_Y = float(lerp(global_position.y, TARGET.y, 0.2))
	global_position = Vector2(TARGET_POS_X, TARGET_POS_Y)

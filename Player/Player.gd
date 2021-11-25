extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 8
const MAX_SPEED = 100
const FRICTION = 10
const AIR_RESISTANCE = 1
const GRAVITY = 4
const JUMP_FORCE = 125

var motion = Vector2.ZERO
var jump_count = 0
var player_position = Vector2(-1,153)

onready var sprite = $Sprite
onready var lazer_muzzle = $LazerMuzzle

func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_input != 0:
#		animationPlayer.play("Run")
		motion.x += x_input * ACCELERATION * delta * TARGET_FPS
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
#		animationPlayer.play("Stand")
		pass
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)		
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
		
	else:
		pass
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)
	
	lazer_muzzle.look_at(get_global_mouse_position())


	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

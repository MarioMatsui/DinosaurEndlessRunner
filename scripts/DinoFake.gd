extends KinematicBody2D

const SPEED = 100
const GRAVITY = 30
const JUMP_FORCE = -650

var motion = Vector2()
var can_jump = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	Jump()
	move_and_slide(motion, Vector2.UP)

func Jump():
	if is_on_floor():
		$AnimDino.play("Idle")
		if Input.is_action_just_pressed("Jump"):
			jumpTime()
			$AnimDino.play("Idle")
	else:
		motion.y += GRAVITY

func jumpTime():
	if can_jump:
		can_jump = false
		motion.y = JUMP_FORCE
		$Jump.play()
		$Timer.start()

func _on_Timer_timeout():
	can_jump = true

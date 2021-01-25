extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$DinoFake.position.x = 87
	$DinoFake.position.y = 592
	$Press.play("Press")
	$AnimMain.play("LogoEntra")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Comecar()

func Comecar():
	if Input.is_action_just_pressed("Jump"):
		$Timer.start()


func _on_Timer_timeout():
	$Timer2.start()
	$AnimMain.play("LogoSai")
	$pressione.visible = false
	$Press.stop()


func _on_Timer2_timeout():
	get_tree().change_scene("res://scenes/Run.tscn")

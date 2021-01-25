extends KinematicBody2D

const SPEED = 100
const JUMP_FORCE = -650

var motion = Vector2()
var gravity = 30

var tempo = 0.0
var intervalo = 3
var intervalo_min = 0.5
var intervalo_max = 3

var state_machine

var morto = false

var Cactos = [preload("res://scenes/Cactos/Cacto1B.tscn"),
				preload("res://scenes/Cactos/Cacto1S.tscn"),
				preload("res://scenes/Cactos/Cacto2B.tscn"),
				preload("res://scenes/Cactos/Cacto2S.tscn"),
				preload("res://scenes/Cactos/Cacto3B.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	state_machine = $AnimationTree.get("parameters/playback")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Jump()
	Down()
	Dead()
	tempo += delta
	
	if get_parent().score >= 250:
		Cactos.append(preload("res://scenes/ptero.tscn"))
		Cactos.append(preload("res://scenes/ptero.tscn"))
		Cactos.append(preload("res://scenes/Cactos/Cacto1B.tscn"))
		Cactos.append(preload("res://scenes/Cactos/Cacto2S.tscn"))
	
	if tempo >= intervalo:
		tempo = 0
		
		#qual cacto?
		var c = rand_range(0, Cactos.size())
		
		get_parent().add_child(Cactos[c].instance())
		
		intervalo = rand_range(intervalo_min, intervalo_max)
	
	
	move_and_slide(motion, Vector2.UP)


func Jump():
	if is_on_floor():
		state_machine.travel("Run")
		if Input.is_action_just_pressed("Jump"):
			motion.y = JUMP_FORCE
			$Jump.play()
			state_machine.travel("Idle")
	else:
		motion.y += gravity

func Down():
	if Input.is_action_pressed("Down"):
		$Area2D/Shape2.disabled = true
		gravity = 130
		state_machine.travel("Down")
	elif Input.is_action_just_released("Down"):
		gravity = 30
	else:
		$Area2D/Shape2.disabled = false

func Dead():
	if morto == true:
		state_machine.travel("Dead")
		
		tempo = 0
		
		get_parent().acabou = true
		get_parent().velocidade.x = 0
		get_parent().pontos = 0
		if Input.is_action_just_pressed("Jump"):
			morto = false
			if get_parent().acabou:
				get_tree().reload_current_scene()
				get_parent().acabou = false
				
			get_parent().comecou = true


func _on_Area2D_area_entered(area):
	get_parent().get_node("Anim").play("Replay")
	morto = true
	get_parent().comecou = false
	$Die.play()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		morto = false
		if get_parent().acabou:
			get_tree().reload_current_scene()
			get_parent().acabou = false

		get_parent().comecou = true

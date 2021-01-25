extends Node2D

var comecou = false
var acabou = false

var velocidade = Vector2(-500, 0)

var highscore = 0
var checkpoint = 0
var score = 0
var pontos = 0

var tempo_vida = 4

var calls_per_sec = 0.13
var time_for_one_call = 0.10

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dino.position.x = 87
	$Dino.position.y = 592
	


func _process(delta):
	Score()
	pontos += delta
	$Score.text = "Score: " + str(score)

func Score():
	if pontos >= time_for_one_call:
		pontos = 0
		score += 1
		checkpoint += 1
	if checkpoint == 100:
		checkpoint = 0
		$Hundred.play()

func _on_Cacto_queue_timeout():
	$Cacto.queue_free()

extends Area2D

onready var main = get_parent()
onready var dinossauro = get_parent().get_node("Dino")

var stay = Vector2(1400, 617)
var velocidade = Vector2(-500, 0)

var tempo_vida = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(stay)

func _physics_process(delta):
	set_position(position + get_node("/root/Run").velocidade * delta)
	
	tempo_vida -= delta
	
	if tempo_vida <= 0:
		queue_free()
	
	if get_parent().acabou == true:
		tempo_vida = 4

extends ParallaxBackground

var parallax_offset = Vector2()


func _ready():
	get_node("ParallaxLayer/Ground").set_position(Vector2(0, 634))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax_offset -= get_node("/root/Run").velocidade * -delta
	set_scroll_offset(parallax_offset)
	
	pass

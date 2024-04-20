extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var viewportWidth = float(get_viewport().size.x)
	var viewportHeight = float(get_viewport().size.y)

	var vertical_scale = viewportHeight / (3 * $Sprite2D.texture.get_size().y)
	var horizontal_scale = viewportWidth / $Sprite2D.texture.get_size().x
	
	print(viewportWidth)
	print(viewportHeight)
	# Optional: Center the sprite, required only if the sprite's Offset>Centered checkbox is set
	$Sprite2D.set_position(Vector2(0, viewportHeight * (1/6) - viewportHeight/3))
	$Sprite2D.set_scale(Vector2(horizontal_scale, vertical_scale))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

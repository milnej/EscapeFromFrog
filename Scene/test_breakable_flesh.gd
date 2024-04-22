extends Node2D

var color_status = 0.0
var elapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get an oscillation of red and normal based on elapsed time
	elapsed += delta
	color_status = ((sin(8*elapsed)+PI)/4)
	$Sprite2D.self_modulate = Color(1,color_status,color_status,1)
	pass

extends Node2D

@onready var bar_conductor = $BarConductor
var bar_scene = preload("res://bar.tscn")

var bars = []
var bar_length = -500
var current_location = Vector2(0, bar_length)

var bar_move_speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(3):
		add_bar()

func _process(delta):
	#print(bar_conductor)
	bar_conductor.position += Vector2(0 , bar_move_speed)

func add_bar():
	var bar = bar_scene.instantiate()
	bar.position = Vector2(current_location.x, current_location.y)
	bars.append(bar)
	bar_conductor.add_child(bar)
	current_location += Vector2(0, bar_length)

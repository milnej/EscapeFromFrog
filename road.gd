extends Node2D

@onready var note_conductor = $NoteConductor
var note_scene = preload("res://note.tscn")

var notes = []
var note_length = -500
var current_location = Vector2(0, note_length)
var note_distance_scale = .25

var note_move_speed = 3

#TODO: Need to make unit scaling more consistent
var notes_data = [
	{
		"pos": 0,
		#"len": 100
	},
	{
		"pos": 400,
		#"len": 100
	},
	{
		"pos": 800,
		#"len": 100
	},
	{
		"pos": 1200,
		#"len": 100
	},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(2):
		add_note(i)

func _process(delta):
	#print(bar_conductor)
	note_conductor.position += Vector2(0 , note_move_speed)

func add_note(note_index):
	var note = note_scene.instantiate()
	# -- Note position are randomized for now for testing
	randomize()
	note.line = randi_range(0,2)
	# --
	note.note_position = note_index * note_distance_scale
	note_conductor.add_child(note)
	#print(note.line)

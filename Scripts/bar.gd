extends Node2D

var note_scn = preload("res://note.tscn")
var note_distance_scale = .25

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
	add_notes()

func add_notes():
	for note_data in notes_data:
		var note = note_scn.instantiate()
		# -- Note position are randomized for now for testing
		randomize()
		note.line = randi_range(0,2)
		# --
		note.note_position = int(note_data.pos) * note_distance_scale
		add_child(note)
		#print(note.line)

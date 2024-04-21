extends Node2D

@onready var note_conductor = $NoteConductor
var note_scene = preload("res://note.tscn")

var note_count = 0
var beat_map_file_name = "res://beatMap1.txt"

var bpm = 60
var note_move_speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():

	var file = FileAccess.open(beat_map_file_name, FileAccess.READ)
	var beat_map_raw = file.get_as_text()
	var beat_map = beat_map_raw.split('\n')
	
	for i in range(len(beat_map)):
		add_note(beat_map[i])

func _process(delta):
	note_conductor.position += Vector2(-note_move_speed, 0)

func add_note(note_lane):

	if note_lane == "-":
		note_count += 1
		return
	var note = note_scene.instantiate()

	note.line = note_lane

	note.note_position = note_count * 100
	note_conductor.add_child(note)
	note_count += 1

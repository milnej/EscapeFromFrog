extends Node2D

@onready var note_conductor = $NoteConductor
var note_scene = preload("res://note.tscn")
var breakable_flesh = preload("res://Scene/breakable_flesh.tscn")

var row_count = 0
var beat_map_file_name = "res://beatMap1.txt"
var note_move_speed
var bpm


const DIST_BETWEEN_NOTES = 200

func parse_beat_map(file_name):
	var file = FileAccess.open(file_name, FileAccess.READ)
	var beat_map_raw = file.get_as_text()
	var beat_map = beat_map_raw.split('\n')
	var out = []
	
	bpm = beat_map[0]
	
	for i in range(1, len(beat_map)):
		var vals = beat_map[i].split(',')
		out.append(vals)
	return out
		

func calculate_note_speed(bpm):
	var note_length = DIST_BETWEEN_NOTES
	var beat_in_seconds = 60/float(bpm)
	note_move_speed = note_length/beat_in_seconds

func _ready():

	var beat_map = parse_beat_map(beat_map_file_name)

	calculate_note_speed(bpm)
	
	for i in range(len(beat_map)):
		add_row(beat_map[i])

func _process(delta):
	note_conductor.position += Vector2(-note_move_speed*delta, 0)

func add_row(row):
	for i in range(len(row)):
		add_note(row[i], i)
	row_count += 1

func add_note(note_type, note_lane):
	var note
	if note_type == "-":
		return
	elif note_type == "bf":
		note = breakable_flesh.instantiate()
	else:
		note = note_scene.instantiate()

	note.line = note_lane
	note.note_position = row_count * DIST_BETWEEN_NOTES
	note_conductor.add_child(note)

extends Node2D

@onready var note_conductor = $NoteConductor
@export var bpm: int = 188
var note_scene = preload("res://note.tscn")

var note_count = 0
var beat_map_file_name = "res://beatMap1.txt"
var note_move_speed
var note_scale

const DIST_BETWEEN_NOTES = 200

func calculate_note_speed(bpm):
	var note_length = DIST_BETWEEN_NOTES
	var beat_in_seconds = 60/float(bpm)
	
	note_move_speed = note_length/beat_in_seconds
	note_scale = note_length/DIST_BETWEEN_NOTES

func _ready():

	var file = FileAccess.open(beat_map_file_name, FileAccess.READ)
	var beat_map_raw = file.get_as_text()
	var beat_map = beat_map_raw.split('\n')

	calculate_note_speed(bpm)
	
	for i in range(len(beat_map)):
		add_note(beat_map[i])

func _process(delta):
	note_conductor.position += Vector2(-note_move_speed*delta, 0)

func add_note(note_lane):

	if note_lane == "-":
		note_count += 1
		return
	var note = note_scene.instantiate()

	note.line = note_lane

	note.note_position = note_count * DIST_BETWEEN_NOTES
	note_conductor.add_child(note)
	note_count += 1

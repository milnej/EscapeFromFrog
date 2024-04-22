extends Node2D

@onready var note_conductor = $NoteConductor
@onready var count_in_timer = $CountInTimer
@onready var count_in_label = $Control/CountInLabel
@onready var ending_screen = $Ending_Screen
var note_scene = preload("res://Scene/note.tscn")
var breakable_flesh = preload("res://Scene/breakable_flesh.tscn")
var unbreakable_flesh = preload("res://Scene/unbreakable_flesh.tscn")
var acid = preload("res://Scene/acid.tscn")
var beetle_trapped = preload("res://Scene/beetle_trapped.tscn")

var row_count = 0
var beat_map_file_name = "res://BeatMaps/easy.txt"
var note_move_speed
var bpm
var current_road_state: ROAD_STATE = ROAD_STATE.COUNT_IN

var time_begin
var time_delay
var time_last_frame = 0

const DIST_BETWEEN_NOTES = 400

enum ROAD_STATE {
		COUNT_IN,
		SONG_PLAYING
	}

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
		

func calculate_note_speed():
	var note_length = DIST_BETWEEN_NOTES
	var beat_in_seconds = 60/float(bpm)
	note_move_speed = note_length/beat_in_seconds

func _ready():
	GlobalVars.song_length = $AudioStreamPlayer.stream.get_length()
	
	var beat_map = parse_beat_map(beat_map_file_name)

	calculate_note_speed()
	
	for i in range(len(beat_map)):
		add_row(beat_map[i])

func _process(delta):
	match current_road_state:
		ROAD_STATE.COUNT_IN:
			count_in_label.text = "%.02f" % count_in_timer.time_left
		ROAD_STATE.SONG_PLAYING:
			# Obtain from ticks.
			var current_songtime = (Time.get_ticks_usec() - time_begin) / 1000000.0
			# Compensate for latency.
			current_songtime -= time_delay
			# May be below 0 (did not begin yet).
			current_songtime = max(0, current_songtime)
			#print("Time is: ", time)
			
			GlobalVars.song_current_time = current_songtime
			
			var delta_songtime = current_songtime - time_last_frame 
			
			note_conductor.position += Vector2(-note_move_speed * (delta_songtime), 0)
			
			time_last_frame = current_songtime

func add_row(row):
	for i in range(len(row)):
		add_note(row[i], i)
	row_count += 1

func add_note(note_type, note_lane):
	var note
	match note_type:
		"--":
			return
		"bf":
			note = breakable_flesh.instantiate()
		"uf":
			note = unbreakable_flesh.instantiate()
		"ac":
			note = acid.instantiate()
		"bt":
			note = beetle_trapped.instantiate()
		_:
			return

	note.line = note_lane
	note.note_position = row_count * DIST_BETWEEN_NOTES
	note_conductor.add_child(note)

func _on_count_in_timer_timeout():
	current_road_state = ROAD_STATE.SONG_PLAYING
	count_in_label.visible = false
	
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$AudioStreamPlayer.play()

func _on_button_pressed():
	count_in_timer.start()
	$Control/Button.visible = false

func _on_audio_stream_player_finished():
	ending_screen.visible = true
	$Ending_Screen/VBoxContainer/SCORE.text = "SCORE: %d" % GlobalVars.score

func _on_return_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scene/menu.tscn")

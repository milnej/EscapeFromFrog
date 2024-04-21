extends Node

@onready var score_label: Label = %ScoreLabel
@onready var timer_label: Label = %TimerLabel
@onready var road: Node2D = $"../Road"
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var beetle: Node2D = $"../Beetle"
@onready var background: Node2D = %Background

var _run_time := 0.0
var _score := 0

func _ready() -> void:
	var cam_center = camera_2d.get_screen_center_position()
	var horizontal_position = cam_center.x - get_viewport().size.x/4
	var vertical_position_increments = get_viewport().size.y/3
	GlobalVars.vertical_position_increments = vertical_position_increments
	GlobalVars.top_beetle_pos = Vector2(horizontal_position, cam_center.y - vertical_position_increments)
	GlobalVars.middle_beetle_pos = Vector2(horizontal_position, cam_center.y)
	GlobalVars.bottom_beetle_pos = Vector2(horizontal_position, cam_center.y + vertical_position_increments)
	var beetle_hurtbox_offset := beetle.find_child("HurtBoxCollider").global_position - beetle.global_position as Vector2
	var middle_beetle_hurtbox_desired_position = GlobalVars.middle_beetle_pos + beetle_hurtbox_offset
	var middle_note_picker_position := road.find_child("NotePickerMiddle").global_position as Vector2
	var reposition_vector = middle_beetle_hurtbox_desired_position - middle_note_picker_position
	road.global_position += reposition_vector
	background.position = camera_2d.position
	for child in road.get_children():
		if child is Note_Picker:
			child.process_mode = Node.PROCESS_MODE_DISABLED
			child.visible = false
	SignalBus.connect("note_collected", _add_score)

func _process(delta: float) -> void:
	_run_time += delta
	
	timer_label.text = "%.2f" % _run_time
	score_label.text = str(_score)

func _add_score(points: int) -> void:
	_score += points

func _update_leaderboard():
	pass

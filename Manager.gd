extends Node

@onready var score_label: Label = %ScoreLabel
@onready var timer_label: Label = %TimerLabel

var _run_time := 0.0
var _score := 0

func _ready() -> void:
	SignalBus.connect("note_collected", _add_score)

func _process(delta: float) -> void:
	_run_time += delta
	
	timer_label.text = "%.2f" % _run_time
	score_label.text = str(_score)

func _add_score(points: int) -> void:
	_score += points
	pass
	


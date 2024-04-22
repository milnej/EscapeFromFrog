class_name Note_Picker extends Node2D

@export var note_number: int

var is_pressed: bool = false
var is_collecting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)
	pass # Replace with function body.


func _input(event):
	match note_number:
		0:
			if event.is_action_pressed("note_left"):
				is_pressed = true
				is_collecting = true
			elif event.is_action_released("note_left"):
				is_pressed = false
				is_collecting = false
		1:
			if event.is_action_pressed("note_middle"):
				is_pressed = true
				is_collecting = true
			elif event.is_action_released("note_middle"):
				is_pressed = false
				is_collecting = false
		2:
			if event.is_action_pressed("note_right"):
				is_pressed = true
				is_collecting = true
			elif event.is_action_released("note_right"):
				is_pressed = false
				is_collecting = false

func _process(delta):
	if is_pressed:
		self.scale = Vector2(2.9, 2.9)
	else:
		self.scale = Vector2(3.0, 3.0)

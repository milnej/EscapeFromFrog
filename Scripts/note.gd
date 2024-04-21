extends Node2D

@export var line: int
@export var note_number: int
var note_position: int  = 0
var is_colliding: bool = false
var is_collected: bool = false
var note_picker: Note_Picker

const NOTE_DISTANCE: int = 185

# Called when the node enters the scene tree for the first time.
func _ready():
	set_note_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collect()


func set_note_position():
	var x
	match line:
		0: # Left
			x = -1
		1: # Middle
			x = 0
		2: # Right
			x = 1

	self.position = Vector2(note_position, x * NOTE_DISTANCE)

func collect():
	if !is_collected:
		if is_colliding and note_picker != null:
			if note_picker.is_collecting:
				is_collected = true
				note_picker.is_collecting = false
				hide()
				SignalBus.note_collected.emit(1)

func _on_area_2d_area_entered(area):
	if area.get_parent() is Note_Picker:
		is_colliding = true;
		note_picker = area.get_parent()

func _on_area_2d_area_exited(area):
	if area.get_parent() is Note_Picker:
		is_colliding = false;

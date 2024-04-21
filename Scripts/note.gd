class_name Note extends Node2D

var guts_manager: Node
var sfx_player: NoteCollectionPlayer
@export var line: int
@export var note_number: int
@export var points_value: int = 1
var note_position: int  = 0
var is_colliding: bool = false
var is_collected: bool = false
var note_picker: Note_Picker
var LANE_DISTANCE: int = 185

signal note_collected

# Called when the node enters the scene tree for the first time.
func _ready():
	if (guts_manager != null and !guts_manager.is_node_ready()):
		await guts_manager.ready
	LANE_DISTANCE = GlobalVars.vertical_position_increments
	set_note_position()
	
	# please do not look at this it is disgusting :)
	var root_node = get_tree().root.get_node("Guts")
	guts_manager = root_node.get_node("GutsManager")
	sfx_player = root_node.get_node("SFXPlayer")
	note_collected.connect(sfx_player.on_note_collected)

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
	self.position = Vector2(note_position, x * LANE_DISTANCE)

func collect():
	if !is_collected:
		if is_colliding and note_picker != null:
			if note_picker.is_collecting:
				is_collected = true
				note_picker.is_collecting = false
				SignalBus.note_collected.emit(points_value)
				note_collected.emit()
				queue_free()

func _on_area_2d_area_entered(area):
	print(area.get_parent() is Note_Picker)
	if area.get_parent() is Note_Picker:
		is_colliding = true;
		note_picker = area.get_parent()
	elif area.get_parent() is Beetle_Player:
		is_colliding = false;
		SignalBus.note_missed.emit()

func _on_area_2d_area_exited(area):
	if area.get_parent() is Note_Picker:
		is_colliding = false;

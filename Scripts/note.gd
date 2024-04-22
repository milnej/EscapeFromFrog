class_name Note extends Node2D

var guts_manager: Node
var sfx_player: NoteCollectionPlayer
@export var line: int
@export var note_number: int
@export var points_value: int = 100
var note_position: int  = 0
var is_colliding_okay: bool = false
var is_colliding_nice: bool = false
var is_colliding_perfect: bool = false
var is_collected: bool = false
var note_picker: Note_Picker
var LANE_DISTANCE: int = 185

signal note_collected
signal note_hit_timing(value: int)

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
	note_hit_timing.connect(guts_manager.display_hit_timing)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	collect()

func set_note_position():
	var x
	match line:
		0: # Left
			x = -1
			$Sprite2D.flip_v = false
		1: # Middle
			x = 0
		2: # Right
			x = 1
			$Sprite2D.flip_v = false
	self.position = Vector2(note_position, x * LANE_DISTANCE)

func collect():
	if !is_collected:
		if note_picker != null:
			if is_colliding_perfect and note_picker.is_collecting:
				is_collected = true
				note_picker.is_collecting = false
				SignalBus.note_collected.emit(points_value * 3)
				note_collected.emit()
				print("PERFECT")
				note_hit_timing.emit(0)
				queue_free()
			elif is_colliding_nice and note_picker.is_collecting:
				is_collected = true
				note_picker.is_collecting = false
				SignalBus.note_collected.emit(points_value * 2)
				note_collected.emit()
				print("Nice")
				note_hit_timing.emit(1)
				queue_free()
			elif is_colliding_okay and note_picker.is_collecting:
				is_collected = true
				note_picker.is_collecting = false
				SignalBus.note_collected.emit(points_value)
				note_collected.emit()
				print("Ok..")
				note_hit_timing.emit(2)
				queue_free()

func _on_nice_area_entered(area):
	if area.get_parent() is Note_Picker:
		is_colliding_nice = true;
		note_picker = area.get_parent()

func _on_perfect_area_entered(area):
	if area.get_parent() is Note_Picker:
		is_colliding_perfect = true;
		note_picker = area.get_parent()

func _on_okay_area_entered(area):
	if area.get_parent() is Note_Picker:
		is_colliding_okay = true;
		note_picker = area.get_parent()
	elif area.get_parent() is Beetle_Player:
		is_colliding_okay = false;
		SignalBus.note_missed.emit()
		note_hit_timing.emit(3)

func _on_okay_area_exited(area):
	if area.get_parent() is Note_Picker:
		is_colliding_okay = false;

func _on_nice_area_exited(area):
	if area.get_parent() is Note_Picker:
		is_colliding_nice = false;

func _on_perfect_area_exited(area):
	if area.get_parent() is Note_Picker:
		is_colliding_perfect = false;

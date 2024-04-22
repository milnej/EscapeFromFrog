class_name Beetle_Player extends Node2D

var top_position : Vector2
var middle_position : Vector2
var bottom_position : Vector2
var is_attacking : bool
var curr_attack_length : float
const max_attack_length := 0.15 # How long an attack can be held down before resetting

enum ROW  {TOP, MIDDLE, BOTTOM}
var row := ROW.MIDDLE

@onready var camera_2d = $"../Camera2D"
@onready var guts_manager: Node = $"../GutsManager"
@onready var beetle_note_picker: Node2D = $BeetleNotePicker

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!guts_manager.is_node_ready()):
		await guts_manager.ready
	top_position = GlobalVars.top_beetle_pos
	middle_position = GlobalVars.middle_beetle_pos
	bottom_position = GlobalVars.bottom_beetle_pos
	_set_sprite()

func _set_sprite():
	match row:
		ROW.TOP:
			position = top_position
			$AnimatedSprite2D.flip_v = true
		ROW.MIDDLE:
			position = middle_position
			$AnimatedSprite2D.flip_v = false
		ROW.BOTTOM:
			position = bottom_position
			$AnimatedSprite2D.flip_v = false
		_:
			pass
	if (!$AnimatedSprite2D.is_playing() || $AnimatedSprite2D.animation != "attack"):
		if row == ROW.MIDDLE:
			$AnimatedSprite2D.animation = "back_wall_running"
		else:
			$AnimatedSprite2D.animation = "running"
	if (is_attacking):
		beetle_note_picker.scale = Vector2(2.8, 2.8)
		$AnimatedSprite2D.animation = "attack"
	else:
		beetle_note_picker.scale = Vector2(3.0, 3.0)
	$AnimatedSprite2D.play()

func _process_input():
	if Input.is_action_just_pressed("beetle_up"):
		match row:
			ROW.TOP:
				row = ROW.TOP
			ROW.MIDDLE:
				row = ROW.TOP
			ROW.BOTTOM: 
				row = ROW.MIDDLE
	elif Input.is_action_just_pressed("beetle_down"):
		match row:
			ROW.TOP:
				row = ROW.MIDDLE
			ROW.MIDDLE:
				row = ROW.BOTTOM
			ROW.BOTTOM: 
				row = ROW.BOTTOM
	elif (Input.is_action_just_pressed("beetle_attack") and not is_attacking):
		is_attacking = true
		curr_attack_length = 0.0
	#elif Input.is_action_just_released("beetle_attack"):
		#is_attacking = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_process_input()
	if (is_attacking):
		curr_attack_length += delta
		beetle_note_picker.is_pressed = true
		beetle_note_picker.is_collecting = true
	else:
		beetle_note_picker.is_pressed = false
		beetle_note_picker.is_collecting = false
	if (curr_attack_length > max_attack_length):
		is_attacking = false
	_set_sprite()
	

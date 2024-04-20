extends Node2D

var top_position : Vector2
var middle_position : Vector2
var bottom_position : Vector2
var is_attacking : bool
var curr_attack_length : float
const max_attack_length := 0.25 # How long an attack can be held down before resetting

enum ROW  {TOP, MIDDLE, BOTTOM}
var row := ROW.TOP

@onready var camera_2d = $"../Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	var cam_center = camera_2d.get_screen_center_position()
	var horizontal_position = cam_center.x - get_viewport().size.x/4
	var vertical_position_increments = get_viewport().size.y/3
	top_position = Vector2(horizontal_position, cam_center.y - vertical_position_increments)
	middle_position = Vector2(horizontal_position, cam_center.y)
	bottom_position = Vector2(horizontal_position, cam_center.y + vertical_position_increments)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (curr_attack_length > max_attack_length):
		is_attacking = false
	if (is_attacking):
		curr_attack_length += delta
		$HurtBox.scale = Vector2(0.8, 0.8)
	else:
		$HurtBox.scale = Vector2(1.0, 1.0)
	if Input.is_action_just_pressed("beetle_top"):
		row = ROW.TOP
	elif Input.is_action_just_pressed("beetle_middle"):
		row = ROW.MIDDLE
	elif Input.is_action_just_pressed("beetle_bottom"):
		row = ROW.BOTTOM
	elif (Input.is_action_just_pressed("beetle_attack") and not is_attacking):
		is_attacking = true
		curr_attack_length = 0.0
	elif Input.is_action_just_released("beetle_attack"):
		is_attacking = false

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
	

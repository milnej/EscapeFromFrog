extends Control

signal back_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button_pressed.connect(get_parent().return_to_start_menu)

func _on_easy_pressed():
	GlobalVars.beatmap = "res://BeatMaps/easy.txt"
	get_tree().change_scene_to_file("res://Scene/guts.tscn")

func _on_medium_pressed():
	GlobalVars.beatmap = "res://BeatMaps/medium.txt"
	get_tree().change_scene_to_file("res://Scene/guts.tscn")

func _on_hard_pressed():
	GlobalVars.beatmap = "res://BeatMaps/hard.txt"
	get_tree().change_scene_to_file("res://Scene/guts.tscn")
	
func _on_back_pressed():
	set_visible_status(false)
	back_button_pressed.emit(self)

func set_visible_status(value: bool):
	self.visible = value
	$CanvasLayer.visible = value

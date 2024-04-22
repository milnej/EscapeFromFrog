extends Control

@export var start: Control
@export var credits: Control
@export var settings: Control
@export var difficulty_select: Control

func _on_start_pressed():
	#get_tree().change_scene_to_file("res://Scene/guts.tscn")
	difficulty_select.set_visible_status(true)
	start.visible = false

func _on_quit_pressed():
	get_tree().quit()

func _on_credits_pressed():
	start.visible = false
	credits.visible = true

func _on_settings_pressed():
	start.visible = false
	settings.visible = true

func return_to_start_menu(current_menu: Control):
	current_menu.visible = false
	start.visible = true

extends Control

@export var start: Control
@export var credits: Control
@export var settings: Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scene/guts.tscn")

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

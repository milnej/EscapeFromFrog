extends Control

signal back_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	back_button_pressed.connect(get_parent().return_to_start_menu)
	
func _on_back_pressed():
	back_button_pressed.emit(self)

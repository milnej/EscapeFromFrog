extends Control

@export var master_slider: Slider
@export var music_slider: Slider
@export var sfx_slider: Slider

signal back_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	master_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	music_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfx_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	back_button_pressed.connect(get_parent().return_to_start_menu)

func _on_master_slider_value_changed(value):
	change_bus_volume("Master", value)

func _on_music_slider_value_changed(value):
	change_bus_volume("Music", value)

func _on_sfx_slider_value_changed(value):
	change_bus_volume("SFX", value)

func change_bus_volume(bus_name: String, volume_value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), volume_value)

func _on_button_pressed():
	back_button_pressed.emit(self)

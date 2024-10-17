extends Control

@onready var label: Label = $VBoxContainer/Label
@onready var h_slider: HSlider = $VBoxContainer/HBoxContainer/HSlider
@onready var check_box: CheckBox = $VBoxContainer/HBoxContainer/CheckBox

@export var bus_name: String

var bus_index: int = 0


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	label.text = str(bus_name) + " Volume"
	
	var volume_settings = ConfigFileHandler.load_volume_settings()
	h_slider.value = volume_settings[bus_name]
	
	var volume_mute_settings = ConfigFileHandler.load_volume_mute_settings()
	check_box.button_pressed = volume_mute_settings[bus_name]
	h_slider.editable = volume_mute_settings[bus_name]


func _on_h_slider_value_changed(value: float) -> void:
	SfxPlayer.play_click_sound()
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_volume_settings(bus_name, h_slider.value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	SfxPlayer.play_click_sound()
	if toggled_on:
		AudioServer.set_bus_mute(bus_index, false)
		h_slider.editable = true
		ConfigFileHandler.save_volume_mute_settings(bus_name, true)
	else:
		AudioServer.set_bus_mute(bus_index, true)
		h_slider.editable = false
		ConfigFileHandler.save_volume_mute_settings(bus_name, false)

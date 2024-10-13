extends Control

@onready var label: Label = $VBoxContainer/Label
@onready var h_slider: HSlider = $VBoxContainer/HBoxContainer/HSlider
@onready var check_box: CheckBox = $VBoxContainer/HBoxContainer/CheckBox

@export var bus_name: String

var bus_index: int = 0


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	label.text = str(bus_name) + " Volume"
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
	if AudioServer.is_bus_mute(bus_index):
		check_box.button_pressed = false
		h_slider.editable = false
	else:
		check_box.button_pressed = true
		h_slider.editable = true


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(bus_index, false)
		h_slider.editable = true
	else:
		AudioServer.set_bus_mute(bus_index, true)
		h_slider.editable = false

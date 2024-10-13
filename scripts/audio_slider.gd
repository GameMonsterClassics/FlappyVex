extends Control

@onready var label: Label = $VBoxContainer/Label
@onready var h_slider: HSlider = $VBoxContainer/HSlider

@export var bus_name: String

var bus_index: int = 0


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	label.text = str(bus_name) + " Volume"
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

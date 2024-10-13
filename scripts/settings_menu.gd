extends Control


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

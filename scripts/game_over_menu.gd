extends Control


func _on_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	get_tree().reload_current_scene()

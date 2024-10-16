extends Control

func _on_quit_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

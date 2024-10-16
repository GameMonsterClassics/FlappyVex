extends Control

@onready var main: Node2D = get_tree().current_scene


func _on_play_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	main.start_game()


func _on_settings_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")


func _on_stats_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	get_tree().change_scene_to_file("res://scenes/player_stats_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

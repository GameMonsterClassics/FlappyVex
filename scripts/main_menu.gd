extends Control

@onready var main: Node2D = get_tree().current_scene


func _on_button_pressed() -> void:
	main.start_game()

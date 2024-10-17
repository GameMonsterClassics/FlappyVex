extends Control

@export var music_name: String
@export var artist_name: String

@export var music_link: String


func _ready() -> void:
	$HBoxContainer/Label.text = music_name + "\nBy " + artist_name


func _on_button_pressed() -> void:
	SfxPlayer.play_click_sound()
	OS.shell_open(music_link)

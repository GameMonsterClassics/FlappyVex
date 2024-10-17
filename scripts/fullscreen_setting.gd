extends Control

@onready var check_box: CheckBox = $HBoxContainer/CheckBox


func _ready() -> void:
	var video_settings = ConfigFileHandler.load_video_settings()
	
	check_box.button_pressed = video_settings.fullscreen


func _on_check_box_toggled(toggled_on: bool) -> void:
	SfxPlayer.play_click_sound()
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		ConfigFileHandler.save_video_settings("fullscreen", true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		ConfigFileHandler.save_video_settings("fullscreen", false)

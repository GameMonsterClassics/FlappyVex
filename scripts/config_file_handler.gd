extends Node

var config = ConfigFile.new()
const SETTINGS_FILE = "user://settings.ini"


func _ready() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE):
		config.set_value("volume", "Master", 1.0)
		config.set_value("volume", "Music", 1.0)
		config.set_value("volume", "SFX", 1.0)
		
		config.set_value("volume_mute", "Master", true)
		config.set_value("volume_mute", "Music", true)
		config.set_value("volume_mute", "SFX", true)
		
		config.set_value("video", "fullscreen", false)
		
		config.save(SETTINGS_FILE)
	else:
		config.load(SETTINGS_FILE)


func save_volume_settings(key: String, value):
	config.set_value("volume", key, value)
	config.save(SETTINGS_FILE)


func load_volume_settings():
	var volume_settings = {}
	
	for key in config.get_section_keys("volume"):
		volume_settings[key] = config.get_value("volume", key)
	
	return volume_settings


func save_volume_mute_settings(key: String, value):
	config.set_value("volume_mute", key, value)
	config.save(SETTINGS_FILE)


func load_volume_mute_settings():
	var volume_mute_settings = {}
	
	for key in config.get_section_keys("volume_mute"):
		volume_mute_settings[key] = config.get_value("volume_mute", key)
	
	return volume_mute_settings


func save_video_settings(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE)


func load_video_settings():
	var video_settings = {}
	
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	
	return video_settings

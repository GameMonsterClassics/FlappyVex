extends AudioStreamPlayer

var music_folder = "res://assets/music/"
var song_list = []
var current_song = null
var previous_song = null
var next_song = null


func _ready() -> void:
	song_list = load_songs()
	
	play_random_song()


func load_songs() -> Array:
	var files = []
	var dir = DirAccess.open(music_folder)
	
	if not dir:
		return []
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if file_name.ends_with(".ogg") or file_name.ends_with(".mp3"):
			files.append(music_folder + file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	
	return files


func select_random_song() -> String:
	var new_song = current_song
	
	while new_song == current_song or new_song == previous_song:
		new_song = song_list[randi() % song_list.size()]
	
	return new_song


func play_random_song():
	next_song = select_random_song()
	
	previous_song = current_song
	current_song = next_song
	
	var stream = ResourceLoader.load(current_song) as AudioStream
	if stream:
		self.stream = stream
		play()
		
		volume_db = -40.0
		create_fade_in_tween()
	
	print("Playing: ", current_song)


func _on_finished() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	play_random_song()
	$Timer.stop()


func create_fade_in_tween():
	var tween = get_tree().create_tween()
	
	tween.tween_property(self, "volume_db", 0, 2.0)

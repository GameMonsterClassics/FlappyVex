extends Node

var game_running: bool = false
var player_touches_ground: bool = false
@onready var player: CharacterBody2D = $"../Player"

var player_scene = preload("res://scenes/player.tscn")


func _process(delta: float) -> void:
	player_dead()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not game_running:
		start_game()


func reset() -> void:
	player_touches_ground = false
	print("Session has been reset.")


func start_game() -> void:
	if not player:
		respawn_player()
	
	if game_running:
		return
	
	reset()
	
	if Input.is_action_just_pressed("ui_accept"):
		print("Game has been started.")
		game_running = true
		#player.flap()


func player_dead() -> void:
	if not player:
		print("Player is dead.")
		game_running = false


func respawn_player() -> void:
	player = player_scene.instantiate()
	get_tree().current_scene.add_child(player)
	player.position = Vector2(128, 256)

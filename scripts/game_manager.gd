extends Node

var game_running: bool = false
var game_over: bool = false
var player_touches_ground: bool = false
var player_hit: bool = false
var score: int = 0
@onready var player: CharacterBody2D = $"../Player"
var scene_path: String = "res://scenes/main.tscn"


func _process(delta: float) -> void:
	player_dead()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not game_running and not game_over:
		start_game()
	elif event.is_action_pressed("ui_accept") and game_over:
		get_tree().reload_current_scene()


func reset() -> void:
	player_touches_ground = false
	print("Session has been reset.")


func start_game() -> void:
	if not player:
		print("No player.")
		return
	
	if game_running:
		return
	
	reset()
	
	if Input.is_action_just_pressed("ui_accept"):
		print("Game has been started.")
		game_running = true
		player.flap()


func player_dead() -> void:
	if not player:
		print("Player dead")
		game_over = true


func add_score() -> void:
	score += 1
	print("Score: " + str(score))

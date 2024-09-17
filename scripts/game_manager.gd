extends Node

var game_running: bool = false
var player_touches_ground: bool = false
@onready var player: CharacterBody2D = $"../Player"


func _process(delta: float) -> void:
	start_game()
	player_dead()


func reset() -> void:
	player_touches_ground = false
	print("Session has been reset.")


func start_game() -> void:
	if not player:
		player.queue_redraw()
	
	if game_running:
		return
	
	reset()
	
	if Input.is_action_just_pressed("ui_accept"):
		print("Game has been started.")
		game_running = true
		player.flap()

func player_dead() -> void:
	if not player:
		print("Player is dead.")
		game_running = false

extends Node

var player_hit: bool = false
var player_touches_ground: bool = false
var game_running: bool = false
var game_over: bool = false
var player_dead: bool = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$"../Player".flap()
		game_running = true

func _physics_process(delta: float) -> void:
	if player_dead:
		game_running = false
		game_over = true
		print("Game Over")

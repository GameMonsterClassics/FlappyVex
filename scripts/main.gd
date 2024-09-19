extends Node2D

var game_running: bool = false
var game_over: bool = false
var player_touches_ground: bool = false
var player_hit: bool = false
var score: int = 0

var min_y_pipe = 100
var max_y_pipe = 300

@export var pipe_scene: PackedScene
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	var preloaded_pipe_1 = pipe_scene.instantiate()
	var preloaded_pipe_2 = pipe_scene.instantiate()
	
	var pipe_1_x_position: int = 400
	var pipe_2_x_position: int = 670
	
	var pipe_1_y_position = randi_range(min_y_pipe, max_y_pipe)
	var pipe_2_y_position = randi_range(min_y_pipe, max_y_pipe)
	
	preloaded_pipe_1.position = Vector2(pipe_1_x_position, pipe_1_y_position)
	preloaded_pipe_2.position = Vector2(pipe_2_x_position, pipe_2_y_position)
	
	add_child(preloaded_pipe_1)
	add_child(preloaded_pipe_2)


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
	
	$Timer.start()


func player_dead() -> void:
	if not player:
		game_over = true


func add_score() -> void:
	score += 1
	print("Score: " + str(score))


func generate_pipe() -> void:
	if not game_running:
		return
	
	var instance = pipe_scene.instantiate()
	
	var x_position = 670
	var y_position = randi_range(min_y_pipe, max_y_pipe)
	
	instance.position = Vector2(x_position, y_position)
	
	add_child(instance)


func _on_timer_timeout() -> void:
	generate_pipe() 

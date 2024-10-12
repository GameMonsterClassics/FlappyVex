extends Node2D

var player_dead: bool = false
var score: int = 0
var game_stage = "not_running"

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
	
	$CanvasLayer/Score.hide()


func _process(delta: float) -> void:
	player_death()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and game_stage == "not_running":
		start_game()
	elif event.is_action_pressed("ui_accept") and game_stage == "over":
		get_tree().reload_current_scene()


func start_game() -> void:
	if game_stage == "running":
		return
	
	$CanvasLayer/MainMenu.hide()
	$CanvasLayer/Score.show()
	
	game_stage = "running"
	player.flap()
	
	$Timer.start()


func player_death() -> void:
	if not player:
		game_stage = "over"


func add_score() -> void:
	score += 1
	$CanvasLayer/Score.text = str(score)


func generate_pipe() -> void:
	if game_stage in ["not_running", "over"]:
		return
	
	var instance = pipe_scene.instantiate()
	
	var x_position = 670
	var y_position = randi_range(min_y_pipe, max_y_pipe)
	
	instance.position = Vector2(x_position, y_position)
	
	add_child(instance)


func _on_timer_timeout() -> void:
	generate_pipe() 

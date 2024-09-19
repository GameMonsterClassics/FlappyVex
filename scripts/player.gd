extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_falling_velocity: int = 700
var is_flying: bool = false
var starting_position: Vector2 = Vector2(128, 256)
var flap_force: int = -400
var player_dead: bool = false

@onready var main: Node2D = get_tree().current_scene


func _ready() -> void:
	position = starting_position


func _physics_process(delta: float) -> void:
	if not main.game_running:
		return
	
	is_player_dead()
	
	velocity.y += gravity * delta
	
	if velocity.y > max_falling_velocity:
		velocity.y = max_falling_velocity
	
	if Input.is_action_just_pressed("ui_accept"):
		flap()
	
	move_and_slide()

func flap() -> void:
	velocity.y = lerp(velocity.y, float(flap_force), 1)


func is_player_dead() -> void:
	if main.player_touches_ground:
		queue_free()
		main.game_running = false
		print("Player is dead.")
	elif position.y < 0:
		queue_free()
		main.game_running = false
		print("Player is dead.")
	elif main.player_hit:
		queue_free()
		main.game_running = false
		print("Player is dead.")

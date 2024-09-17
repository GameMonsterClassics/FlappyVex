extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_falling_velocity: int = 700
var is_flying: bool = false
var starting_position: Vector2 = Vector2(128, 256)
var flap_force: int = -550
var player_dead: bool = false

@onready var game_manager: Node = %GameManager


func _ready() -> void:
	position = starting_position


func _physics_process(delta: float) -> void:
	if not game_manager.game_running:
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
	if game_manager.player_touches_ground:
		queue_free()
		game_manager.player_dead = true
	elif position.y < 0:
		queue_free()
		game_manager.player_dead = true

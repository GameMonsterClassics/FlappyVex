extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_falling_velocity: int = 700
var starting_position: Vector2 = Vector2(128, 256)
var flap_force: int = -400
var mouse_pressed: bool = false

@onready var main: Node2D = get_tree().current_scene


func _ready() -> void:
	position = starting_position


func _physics_process(delta: float) -> void:
	if main.game_stage in ["not_running", "over"]:
		return
	
	player_death()
	
	set_rotation(deg_to_rad(velocity.y * 0.05))
	$AnimatedSprite2D.play()
	
	velocity.y += gravity * delta
	
	if velocity.y > max_falling_velocity:
		velocity.y = max_falling_velocity
	
	if Input.is_action_just_pressed("ui_accept"):
		flap()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not mouse_pressed:
		flap()
		mouse_pressed = true
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_pressed = false
	
	move_and_slide()

func flap() -> void:
	velocity.y = lerp(velocity.y, float(flap_force), 1)
	SaveFileHandler.total_flap += 1


func player_death() -> void:
	if main.player_dead or position.y < 0:
		queue_free()
		main.game_stage = "over"
		SaveFileHandler.total_run += 1
		SaveFileHandler.total_time += int(Time.get_ticks_msec() / (1000 * 60))
		SaveFileHandler.save_game()

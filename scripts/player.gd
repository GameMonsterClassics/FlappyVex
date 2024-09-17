extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_falling_velocity: int = 700
var is_flying: bool = false
var starting_position: Vector2 = Vector2(128, 256)
var flap_force: int = -550


func _ready() -> void:
	position = starting_position


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if velocity.y > max_falling_velocity:
		velocity.y = max_falling_velocity
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = lerp(velocity.y, float(flap_force), 1)
	elif position.y < 0:
		set_rotation(PI/2)
	
	move_and_slide()

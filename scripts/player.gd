extends CharacterBody2D

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_falling_velocity: int = 700
var flap_force: int = -550
var is_flying: bool = false
var is_falling: bool = false
var starting_position: Vector2 = Vector2(128, 256)


func _ready() -> void:
	is_flying = true
	position = starting_position


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if velocity.y > max_falling_velocity:
		velocity.y = max_falling_velocity
	
	if is_flying:
		$AnimatedSprite2D.play()
	
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = flap_force
	
	move_and_slide()

extends Area2D

var scroll
const SCROLL_SPEED : float = 2.5
var screen_size : Vector2i

@onready var main: Node2D = get_tree().current_scene


func _ready() -> void:
	screen_size = get_window().size
	scroll = 0


func _process(delta: float) -> void:
	if not main.game_running:
		return
	
	scroll += SCROLL_SPEED
	
	if scroll >= screen_size.x:
		scroll = 0
	
	position.x = -scroll


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		main.player_touches_ground = true

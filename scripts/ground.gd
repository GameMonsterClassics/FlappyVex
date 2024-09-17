extends Area2D

var scroll
const SCROLL_SPEED : int = 3
var screen_size : Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	scroll = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scroll += SCROLL_SPEED
	
	if scroll >= screen_size.x:
		scroll = 0
	
	position.x = -scroll

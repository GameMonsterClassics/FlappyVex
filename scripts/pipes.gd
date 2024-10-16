extends Area2D

@onready var main: Node2D = get_tree().current_scene


func _process(delta: float) -> void:
	if main.game_stage == "running":
		position.x -= 3


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		main.player_dead = true


func _on_score_area_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		main.add_score()

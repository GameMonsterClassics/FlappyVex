extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var label_2: Label = $HBoxContainer/Label2

@export var stat_type: String


func _ready() -> void:
	if stat_type == "high_score":
		label.text = "High Score"
		label_2.text = str(SaveFileHandler.high_score)
	elif stat_type == "total_score":
		label.text = "Total Score"
		label_2.text = str(SaveFileHandler.total_score)
	elif stat_type == "total_flap":
		label.text = "Total Flap"
		label_2.text = str(SaveFileHandler.total_flap)
	elif stat_type == "total_run":
		label.text = "Total Run"
		label_2.text = str(SaveFileHandler.total_run)
	elif stat_type == "total_time":
		label.text = "Total Time (min)"
		label_2.text = str(SaveFileHandler.total_time)

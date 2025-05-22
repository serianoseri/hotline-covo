extends Node2D

@onready var progress_bar = $ProgressBar
@onready var progress_text = $ProgressBar/Value
var max_health:int
var health:int

func initialize(_max_health:int):
	max_health = _max_health
	health = _max_health
	progress_bar.max_value = _max_health
	update_progress(_max_health)

func decrease_health(new_health: int):
	health = clamp(health - new_health, 0, max_health)
	update_progress(health)
	if health == 0:
		progress_bar.visible = false

func update_progress(decrease_health:int):
	progress_bar.value = decrease_health
	progress_text.text = str(decrease_health)

func is_dead():
	if health > 0:
		return false
	else:
		return true

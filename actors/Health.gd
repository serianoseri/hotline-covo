extends Node2D

@export var health:int = 100

func decrease_health(new_health: int):
	health = clamp(health - new_health, 0, 100)

func is_dead():
	if health > 0:
		return false
	else:
		return true

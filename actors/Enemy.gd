extends CharacterBody2D
class_name Enemy

@export var max_health:int = 100

@onready var health_stat = $Health
@onready var anim_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	print(max_health)
	health_stat.initialize(max_health)

func handle_hit():
	health_stat.decrease_health(20)
	
	if health_stat.is_dead():
		anim_player.play("enemy_death")

func is_dead():
	return health_stat.is_dead()

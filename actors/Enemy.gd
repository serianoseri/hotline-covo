extends CharacterBody2D
class_name Enemy

@onready var health_stat = $Health
@onready var anim_player = $AnimationPlayer
@onready var collision_shape = $CollisionShape2D

func handle_hit():
	if health_stat.health <= 0 and !collision_shape.disabled:
		anim_player.play("enemy_death")
		collision_shape.disabled = true
	else:
		health_stat.health -= 20

func is_dead():
	return health_stat.is_dead()

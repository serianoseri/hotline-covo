extends Node2D

signal weapon_fired(bullet, _transform)

@export var Bullet:PackedScene

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var anim_player = $AnimationPlayer
@export var wait_time:float = 0.2
@export var spray_value:float = 5
var spray:Transform2D

func _ready() -> void:
	attack_cooldown.set_wait_time(wait_time)

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()
		spray = end_of_gun.global_transform
		var rand_spray = randf_range(-spray_value/2, spray_value/2)
		# gun rotation + (rand between -angle/2 and angle/2)
		spray.x = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).x
		spray.y = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).y
		emit_signal("weapon_fired", bullet_instance, spray)
		attack_cooldown.start()
		anim_player.play("muzzle_flash")

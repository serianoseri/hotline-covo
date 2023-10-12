extends Node2D

signal weapon_fired(bullet, _transform)

@export var Bullet:PackedScene

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var anim_player = $AnimationPlayer

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instantiate()
		emit_signal("weapon_fired", bullet_instance, end_of_gun.global_transform)
		attack_cooldown.start()
		anim_player.play("muzzle_flash")

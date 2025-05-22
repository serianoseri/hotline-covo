extends Node2D

signal weapon_fired(bullet, _transform)
signal update_ammo(amount: int)

@export var Bullet:PackedScene

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var anim_player = $AnimationPlayer
@export var wait_time:float = 0.2
@export var spray_value:float = 5
@export var mag_size:int = 30
@export var damage:int = 20
var spray:Transform2D
var bullet_count:int

func _process(delta):
	emit_signal("update_ammo", bullet_count)

func _ready() -> void:
	attack_cooldown.set_wait_time(wait_time)
	bullet_count = mag_size
	emit_signal("update_ammo", mag_size)

func shoot():
	if attack_cooldown.is_stopped() and Bullet != null and !(bullet_count == 0):
		var bullet_instance = Bullet.instantiate()
		spray = end_of_gun.global_transform
		var rand_spray = randf_range(-spray_value/2, spray_value/2)
		# gun rotation + (rand between -angle/2 and angle/2)
		spray.x = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).x
		spray.y = spray.rotated(end_of_gun.rotation + deg_to_rad(rand_spray)).y
		bullet_instance.damage = damage
		emit_signal("weapon_fired", bullet_instance, spray)
		attack_cooldown.start()
		decrease_bullet_count(1)
		print(bullet_count)
		anim_player.play("muzzle_flash")

func decrease_bullet_count(decrease_amount:int):
	bullet_count = clamp(bullet_count - decrease_amount, 0, mag_size)
	emit_signal("update_ammo", bullet_count)

extends Node2D

signal weapon_fired(bullet, _transform)
signal update_ammo(amount: int)

enum state{IDLE, SHOOTING, RELOADING, RUNNING}

@export var Bullet:PackedScene

@onready var end_of_gun = $EndOfGun
@onready var attack_cooldown = $AttackCooldown
@onready var reload_cooldown = $ReloadCooldown
@onready var reload_progress = $reload_hud
@onready var anim_player = $AnimationPlayer
@export var attack_cooldown_time:float = 0.1
@export var reload_cooldwon_time:float = 2.4
@export var spray_value:float = 5
@export var mag_size:int = 30
@export var damage:int = 34
var spray:Transform2D
var bullet_count:int

func _process(delta):
	emit_signal("update_ammo", bullet_count)
	if !reload_cooldown.is_stopped():
		reload_progress.set_value(reload_cooldown.time_left)

func _ready() -> void:
	attack_cooldown.set_wait_time(attack_cooldown_time)
	reload_cooldown.set_wait_time(reload_cooldwon_time)
	bullet_count = mag_size
	$MuzzleFlash.visible = false
	reload_progress.max_value = reload_cooldwon_time
	reload_progress.visible = false

func shoot():
	if attack_cooldown.is_stopped() and !(bullet_count == 0) and reload_cooldown.is_stopped():
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

func reload():
	if reload_cooldown.is_stopped() and bullet_count < mag_size:
		reload_progress.visible = true
		reload_cooldown.start()
		await reload_cooldown.timeout
		bullet_count = mag_size
		reload_progress.visible = false

func decrease_bullet_count(decrease_amount:int):
	bullet_count = clamp(bullet_count - decrease_amount, 0, mag_size)

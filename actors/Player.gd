extends CharacterBody2D
class_name Player

signal player_fired_bullet(bullet, transform)

@export var speed = 400
@onready var weapon = $Weapon
@onready var health_stat = $Health

func _ready():
	weapon.connect("weapon_fired", self.shoot)
	emit_signal("update_ammo", weapon.mag_size)
	print(get_tree().World_Boundaries.get_children())

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("left","right","up","down").normalized()
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("click"):
		weapon.shoot()
	
	if Input.is_action_pressed("reload"):
		weapon.reload()

func shoot(bullet_instance, _transform):
	emit_signal("player_fired_bullet", bullet_instance, _transform)
	emit_signal("update_ammo", weapon.bullet_count)

func reload():
	weapon.reload_cooldown.is_stopped()

func handle_hit(damage:int):
	pass
	#health_stat.health -= 20

func is_dead():
	return health_stat.is_dead()

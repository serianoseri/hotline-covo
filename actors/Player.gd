extends CharacterBody2D
class_name Player

signal player_fired_bullet(bullet, transform)

@export var speed = 400
@onready var weapon = $Weapon
@onready var health_stat = $Health

func _ready():
	weapon.connect("weapon_fired", self.shoot)

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	
	move_and_slide()
	if Input.is_action_pressed("click"):
		weapon.shoot()

#func _unhandled_input(event):
	#if event.is_action_released("click"):
		#weapon.shoot()

func shoot(bullet_instance, _transform):
	emit_signal("player_fired_bullet", bullet_instance, _transform)

func handle_hit():
	health_stat.health -= 20

func is_dead():
	return health_stat.is_dead()

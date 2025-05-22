extends Node2D
class_name Main

@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player
@onready var hud: CanvasLayer = $Hud

func _ready():
	player.connect("player_fired_bullet", bullet_manager.handle_bullet_spawned)
	player.weapon.connect("update_ammo", hud.update_ammo)

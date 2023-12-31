extends Node2D
class_name Main

@onready var bullet_manager = $BulletManager
@onready var player: Player = $Player

func _ready():
	player.connect("player_fired_bullet", bullet_manager.handle_bullet_spawned)

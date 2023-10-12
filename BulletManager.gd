extends Node2D

func handle_bullet_spawned(bullet, _transform):
	bullet.transform = _transform
	add_child(bullet)

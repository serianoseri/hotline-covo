extends Area2D
class_name Bullet

@export var speed = 700
var direction = Vector2.DOWN

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_kill_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.has_method("handle_hit") and body.has_method("is_dead"):
		body.handle_hit()
		if !body.is_dead():
			queue_free()

extends "res://src/scripts/bullet_player.gd"

func _bullet_direction():
	return Vector2(0,1)

func _on_body_entered(body):
	if body.has_method("_take_damage"):
		queue_free()
		body._take_damage()

extends Area2D

var travelled_distance = 0
var velocity = Vector2.ZERO

func _physics_process(delta):
	const speed = 1000
	const weapon_range = 1200
	var velocity = _bullet_direction()
	position += velocity * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > weapon_range: 
		queue_free()

func _bullet_direction():
	return Vector2(0,-1)
	
func _on_body_entered(body):
	queue_free()
	if body.has_method("_take_damage"):
		body._take_damage()
	else:
		body.queue_free()
		if body.get_parent().has_method("_increase_speed"):
			body.get_parent()._increase_speed()
			body.get_parent()._enemy_killed()


func _on_area_entered(area):
	queue_free()
	if area.has_method("_take_damage"):
		area._take_damage()
	elif area.is_in_group("gBullet"):
		area.queue_free()

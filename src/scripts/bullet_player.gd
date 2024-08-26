extends Area2D

var travelled_distance = 0

func _physics_process(delta):
	const speed = 1000
	const weapon_range = 1200
	var direction = _bullet_direction()
	position += direction * speed * delta
	
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

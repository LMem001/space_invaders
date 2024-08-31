extends CharacterBody2D

var travelled_distance = 0
var speed = 1

func _physics_process(delta):
	move_and_slide()
	
	travelled_distance += speed * delta
	if travelled_distance > 300: 
		queue_free()

func _move_direction(x_speed):
	speed = x_speed
	var direction = Vector2(x_speed, 0)
	velocity = direction * 20

func _take_damage():
	queue_free()
	var enemies = get_parent().get_node("Enemies")
	enemies._add_bonus_points(1200)

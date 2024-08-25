extends Node2D

var enemy_speed : float = 100.0
var velocity = Vector2(180, 0)
var bCollidedRight = false

func _physics_process(delta):
	position += velocity * delta
	for enemy in get_children():
		if enemy is CharacterBody2D:
			enemy.move_and_slide()

func _move_down ():
	velocity = Vector2(0, 90)
	%MoveDownTimer.start()

func _on_wall_ritght_area_body_entered(body):
	if body.is_in_group("gEnemy") && !bCollidedRight:
		bCollidedRight = true
		_move_down()

func _on_wall_left_area_body_entered(body):
	if body.is_in_group("gEnemy") && bCollidedRight:
		bCollidedRight = false
		_move_down()

func _on_move_down_timer_timeout():
	if bCollidedRight: 
		velocity = Vector2(-180, 0)
	else:
		velocity = Vector2(180, 0)

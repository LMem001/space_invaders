extends Node2D

@export var red_enemy_scene : PackedScene  # enemy package
var enemy_speed : float = 100.0
var velocity = Vector2(180, 0)
var bCollidedRight = false
var num_red_enemies = 10

func _physics_process(delta):
	position += velocity * delta
	for enemy in get_children():
		if enemy is CharacterBody2D:
			enemy.move_and_slide()

func _ready():
	# Aggiungi nemici all'avvio della scena
	add_enemies(num_red_enemies)

func _move_down ():
	velocity = Vector2(0, 90)
	%MoveDownTimer.start()
	
func add_enemies(count):
	for i in range(count):
		var enemy_instance = red_enemy_scene.instantiate() 
		enemy_instance.position = Vector2(100 + i * 50, 100) 
		add_child(enemy_instance)

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

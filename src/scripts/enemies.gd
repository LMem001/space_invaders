extends Node2D

@export var red_enemy_scene : PackedScene  # enemy package
@export var yellow_enemy_scene : PackedScene  # enemy package
@export var green_enemy_scene : PackedScene  # enemy package
@export var bullet_scene : PackedScene  # Bullet package
@export var Points : Label  # Path to the paddle node
@export var points : int
var bx_positive = true
var enemy_speed : float = 100.0
var e_speed = 100
var velocity = Vector2(e_speed, 0)
var bCollided = false
var num_red_enemies = 20
var num_yellow_enemies = 20
var num_green_enemies = 20
var p_distance = 1

func _physics_process(delta):
	position += velocity * delta
	for enemy in get_children():
		if enemy is CharacterBody2D:
			enemy.move_and_slide()

func _ready():
	# Aggiungi nemici all'avvio della scena
	add_enemies(red_enemy_scene, num_red_enemies, 100)
	add_enemies(yellow_enemy_scene, num_yellow_enemies, 50)
	add_enemies(green_enemy_scene, num_green_enemies, 0)

func _move_down ():
	bx_positive = false
	velocity = Vector2(0, 100)
	%MoveDownTimer.start()
	
func add_enemies(enemy_scene, count, y_position):
	for i in range(count):
		var enemy_instance = enemy_scene.instantiate() 
		enemy_instance.position = Vector2(100 + i * 50, y_position) 
		add_child(enemy_instance)

func _increase_speed():
	e_speed = e_speed + 3 if e_speed > 0 else e_speed - 3
	points += (e_speed if e_speed > 0 else - e_speed) * 10 / p_distance
	Points.text = str(points)
	if bx_positive == true:
		velocity = Vector2(e_speed, 0)

func fire_bullet(start_position: Vector2):
	var bullet_instance = bullet_scene.instantiate()  # Crea un'istanza del proiettile
	bullet_instance.position = start_position
	add_child(bullet_instance)  # Aggiungi il proiettile alla scena
	bullet_instance.velocity = Vector2(0, 300)  # Imposta la velocità del proiettile

func _on_wall_ritght_area_body_entered(body):
	if body.is_in_group("gEnemy") && !bCollided:
		bCollided = true
		_move_down()

func _on_wall_left_area_body_entered(body):
	if body.is_in_group("gEnemy") && !bCollided:
		bCollided = true
		_move_down()

func _on_move_down_timer_timeout():
	p_distance += 1
	if bCollided: 
		e_speed = -e_speed
		velocity = Vector2(e_speed, 0)
		bx_positive = true
	bCollided = false

func _on_shooting_timer_timeout():
	var enemies = get_tree().get_nodes_in_group("gEnemy")
	if enemies.size() > 0:
		var random_enemy = enemies[randi() % enemies.size()]  # select random enemy
		fire_bullet(random_enemy.position)  

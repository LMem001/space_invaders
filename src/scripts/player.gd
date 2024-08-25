extends CharacterBody2D

var initial_position = Vector2()
var _bshot_timeout = true
var _gun_fire_rate = 0.3

func _physics_process(delta):
	_move_direction()
	move_and_slide()
	if Input.is_action_just_pressed("fire"):
		if _bshot_timeout:
			shot()
			# set timeout to prevent next shot
			%ShotTimer.start(_gun_fire_rate)
			_bshot_timeout = false

func _ready():
	initial_position = position
	
func _move_direction():
	var direction = Input.get_vector("move_left", "move_right", "", "")
	velocity = direction * 600

func shot():
	var bullet = preload("res://src/scenes/bullet_player.tscn")
	var new_bullet = bullet.instantiate()
	new_bullet.position = %ShootingPoint.position
	%ShootingPoint.add_child(new_bullet)

func reset_player():
	position = initial_position


func _on_shot_timer_timeout():
	_bshot_timeout = true

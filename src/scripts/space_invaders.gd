extends Node2D

@export var Mothership : PackedScene  # mothership package
var b_from_left = true

func _ready():
	if SAVELOAD.high_score:
		%HighScore.text = str(SAVELOAD.high_score)

func _unhandled_input(event):
	# Verifica se il tasto "start_game" è premuto e la velocità è zero
	if event.is_action_pressed("stop_game"):
		_stop_game("Pause", true)

func _stop_game(label, b_continue):
	%Pause.visible = true
	%ContinueButton.visible = b_continue
	%DescriptionLabel.text = label
	if (!b_continue && %Enemies.points > SAVELOAD.high_score && label == "You Won"):
		SAVELOAD.high_score = %Enemies.points
		%HighScore.text = str(%Enemies.points)
		SAVELOAD.save_score()
	get_tree().paused = true

func _on_continue_button_pressed():
	%Pause.visible = false
	get_tree().paused = false

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_mothership_timer_timeout():
	var mothership_instance = Mothership.instantiate()
	if b_from_left:
		print("left")
		mothership_instance.position = Vector2(20, 20)
		mothership_instance._move_direction(30)
		b_from_left = false
	else:
		print("right")
		mothership_instance.position = Vector2(1400, 20)
		mothership_instance._move_direction(-30)
		b_from_left = true
	add_child(mothership_instance)

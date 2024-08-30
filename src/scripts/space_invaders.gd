extends Node2D

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
	if (!b_continue && %Enemies.points > SAVELOAD.high_score):
		SAVELOAD.high_score = %Enemies.points
		SAVELOAD.save_score()
	get_tree().paused = true

func _on_continue_button_pressed():
	%Pause.visible = false
	get_tree().paused = false

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

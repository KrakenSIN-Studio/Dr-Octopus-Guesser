extends Node

onready var title = $Title
onready var objectif = $Objectif
onready var message = $Message
onready var btnCorrect = $Correct
onready var btnLesser = $Lesser
onready var btnRight = $Greater
onready var introTimer = $Timer

var guess
var min_guessed = 0
var max_guessed = 1000
var ended = false
var timer_to_choose = 5

func _ready():
	print("welcome in the game")
	title.push_align(1)
	objectif.text = "Choose a number between 0 and 1000"
	guess = (min_guessed + max_guessed) / 2 
	message.text = "3s remaind to choose a number"
	pass

func _process(delta):
	if Input.is_action_just_pressed("up"):
		_try_guess("up")
	elif Input.is_action_just_pressed("down"):
		_try_guess("down")
	elif Input.is_action_just_pressed("space"):
		if ended:
			_restart_game()
		else:
			_end_game()

func _on_Correct_pressed():
	if ended:
		_restart_game()
	else:
		_end_game()
	pass

func _on_Greater_pressed():
	_try_guess("up")
	pass
	
func _on_Lesser_pressed():
	_try_guess("down")
	pass

func _on_Timer_timeout():
	print("j'ai fini")
	message.text = "Is it " + str(guess) + " ?"
	pass 

func _try_guess(type):
	if type == "up":
		min_guessed = guess
	else:
		max_guessed = guess
	guess = (min_guessed + max_guessed) / 2
	message.text = "Is it " + str(guess) + " ?"
	pass

func _end_game():
	ended = true
	message.text = "Well, ME the greatest of all octopus knew it, it was " + str(guess) + " !"
	btnCorrect.text = "Restart"

func _restart_game():
	get_tree().reload_current_scene()

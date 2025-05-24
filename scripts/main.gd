extends Node2D

@onready var state_manager: StateManager = $StateManager

var shown_game_over = false

func _ready() -> void:
	state_manager.initialize()

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("pause"):
		#state_manager.show_pause()
	if Global.num_angry == 3 and !shown_game_over:
		state_manager.switch_to("res://scenes/game_over_screen.tscn", "GameOverScreen")
		shown_game_over = true

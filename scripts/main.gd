extends Node2D
class_name Main

@onready var state_manager: StateManager = $StateManager

var shown_game_over = false

func _ready() -> void:
	state_manager.show_menu()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		state_manager.show_pause()
	if Global.num_angry == 3 and !shown_game_over:
		DayAndNightCycleManager.pause()
		state_manager.switch_to("res://scenes/UI/game_over_screen.tscn", "GameOverScreen")
		shown_game_over = true

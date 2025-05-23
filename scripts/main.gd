extends Node2D

@onready var state_manager: StateManager = $StateManager

func _ready() -> void:
	state_manager.initialize()

func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("pause"):
		#state_manager.show_pause()
	pass
	

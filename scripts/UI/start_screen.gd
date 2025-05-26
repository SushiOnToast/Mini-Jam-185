extends Control

class_name PauseScreen

@onready var text: TextureRect = $TextureRect
@onready var state_manager: StateManager = get_tree().get_root().find_child("StateManager", true, false)

func _ready():
	text.hide()
	
	await get_tree().create_timer(1.0).timeout
	
	text.show()
	$AnimationPlayer.play("show")
	await $AnimationPlayer.animation_finished
	
func _process(delta) -> void:
	if text.visible:
		if Input.is_action_just_pressed("quit"):
			get_tree().quit()
		if Input.is_action_just_pressed("ui_accept"):
			state_manager.initialize()
			

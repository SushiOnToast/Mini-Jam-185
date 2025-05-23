extends NodeState

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var direction: Vector2
var animation_direction: String

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = GameInputEvent.movement_input()
	animation_direction = GameInputEvent.get_animation_direction(direction)
	animated_sprite_2d.play("idle_%s" % animation_direction)
	
	

func _on_next_transitions() -> void:
	var moving = GameInputEvent.is_movement_input(direction)
	if moving:
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass

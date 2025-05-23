extends NodeState

@export var player: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

var direction: Vector2
var animation_direction: String

const SPEED = 125.0

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = GameInputEvent.movement_input()
	animation_direction = GameInputEvent.get_animation_direction(direction)
	animated_sprite_2d.play("walk_%s" % animation_direction)
	
	player.velocity = direction * SPEED
	player.move_and_slide()
	

func _on_next_transitions() -> void:
	var moving = GameInputEvent.is_movement_input(direction)
	if !moving:
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass

extends CharacterBody2D

class_name NPC

@export var target_position: Vector2
@export var door_pos: Vector2
@export var queue_pos: int

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var dragging := false
var offset := Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if get_global_mouse_position().distance_to(global_position) < 8: 
					dragging = true
					offset = global_position - get_global_mouse_position()
			else:
				if dragging:
					dragging = false
					#emit_signal("dropped", global_position)  
					self.scale = Vector2(1, 1)

	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + offset
		self.scale = Vector2(1.1, 1.1)
		

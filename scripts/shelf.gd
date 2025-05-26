extends Area2D

@export var draggable_scene: PackedScene  # Assign DraggableObject.tscn in the inspector
@export var parent: Node2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_spawn_and_start_drag()

func _spawn_and_start_drag() -> void:
	if draggable_scene:
		if parent.get_children().size() == 1:
			return
		else:
			var new_obj: Node2D = draggable_scene.instantiate()
			parent.add_child(new_obj)
			new_obj.global_position = get_global_mouse_position()

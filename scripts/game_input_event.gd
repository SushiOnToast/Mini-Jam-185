class_name GameInputEvent

static func movement_input() -> Vector2:
	
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	return direction
	
static func is_movement_input(direction) -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true
		
static func get_animation_direction(direction) -> String:
	if direction == Vector2.UP:
		Global.player_direction = "up"
	elif direction == Vector2.DOWN:
		Global.player_direction = "down"
	elif direction == Vector2.LEFT:
		Global.player_direction = "left"
	elif direction == Vector2.RIGHT:
		Global.player_direction = "right"
		
	return Global.player_direction
		

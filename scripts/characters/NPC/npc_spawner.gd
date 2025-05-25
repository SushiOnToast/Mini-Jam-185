extends Node2D

@onready var npc = preload("res://scenes/characters/npc.tscn")
@onready var npc_list: Node2D = $"../NPCs"
@onready var queue_manager: Node2D = $"../QueueManager"
@onready var exit_point1: Marker2D = $"../NPCExitManager/ExitPoint1"
@onready var exit_point2: Marker2D = $"../NPCExitManager/ExitPoint2"

func _on_spawn_timer_timeout() -> void:
	if npc_list.get_children().size() - 1 == queue_manager.get_children().size():
		return
	
	var new_npc = npc.instantiate()
	
	var offset = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	new_npc.position = position + offset
	new_npc.gender = randi_range(0, 1)
	if new_npc.gender:
		new_npc.exit_position = exit_point2.position
	else:
		new_npc.exit_position = exit_point1.position
	get_parent().get_node("NPCs").add_child(new_npc)

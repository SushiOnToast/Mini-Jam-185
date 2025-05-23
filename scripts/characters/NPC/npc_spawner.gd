extends Node2D

@onready var npc = preload("res://scenes/characters/npc.tscn")
@onready var npc_list: Node2D = $"../NPCs"
@onready var queue_manager: Node2D = $"../QueueManager"

func _on_spawn_timer_timeout() -> void:
	if npc_list.get_children().size() - 1 == queue_manager.get_children().size():
		return
	
	var new_npc = npc.instantiate()
	
	var offset = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	new_npc.position = position + offset
	
	get_parent().get_node("NPCs").add_child(new_npc)

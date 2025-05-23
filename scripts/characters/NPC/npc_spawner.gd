extends Node2D

@onready var npc = preload("res://scenes/characters/npc.tscn")

func _on_spawn_timer_timeout() -> void:
	var new_npc = npc.instantiate()
	
	var offset = Vector2(randf_range(-8, 8), randf_range(-8, 8))
	new_npc.position = position + offset
	
	get_parent().get_node("NPCs").add_child(new_npc)

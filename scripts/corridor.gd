extends Node2D

@onready var npcs: Node2D = $NPCs
@onready var male_occupied_slot: Node2D = $StallManager/Slots/MaleOccupiedSlot
@onready var female_occupied_slot: Node2D = $StallManager/Slots/FemaleOccupiedSlot

func _process(delta: float) -> void:
	if Global.clear_npcs:
		remove_all_npcs()

func remove_all_npcs() -> void:
	for container in [npcs, male_occupied_slot, female_occupied_slot]:
		for child in container.get_children():
			if child is NPC:
				child.queue_free()

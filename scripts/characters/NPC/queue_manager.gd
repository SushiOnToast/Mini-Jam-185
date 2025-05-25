extends Node2D
class_name QueueManager

@onready var npc_list: Node2D = $"../NPCs"
@onready var male_door: Area2D = $"../StallManager/MaleDoor"

@onready var male_occupied: Node2D = $"../StallManager/MaleOccupiedSlot"
@onready var female_occupied: Node2D = $"../StallManager/FemaleOccupiedSlot"

func _process(_delta: float) -> void:
	var all_children = npc_list.get_children()
	var npcs = []

	for child in all_children:
		if child is NPC:
			if child.entered_toilet:
				move_to_occupied_slot(child)
			else:
				npcs.append(child)

	var queue_positions = self.get_children()
	set_queue_positions(npcs, queue_positions)


func set_queue_positions(npcs, queue_positions):
	for i in range(min(npcs.size(), queue_positions.size())):
		npcs[i].target_position = queue_positions[i].position
		npcs[i].door_pos = male_door.position
		npcs[i].queue_pos = i
		
func move_to_occupied_slot(npc: NPC) -> void:
	var old_parent = npc.get_parent()
	var target_parent = male_occupied
	
	if npc.gender:
		target_parent = female_occupied

	if old_parent:
		old_parent.remove_child(npc)

	target_parent.add_child(npc)
	npc.global_position = target_parent.global_position  # or keep npc.global_position unchanged

extends Node2D
class_name QueueManager

@onready var npc_list: Node2D = $"../NPCs"
@onready var male_door: Area2D = $"../StallManager/MaleDoor"

var remove_front = false

func _process(_delta: float) -> void:
	var all_children = npc_list.get_children()
	var npcs = []

	# Only include nodes that are NPCs
	for child in all_children:
		if child is NPC:
			npcs.append(child)

	var queue_positions = self.get_children()

	## Only remove the front NPC when the stall opens
	#if Global.stall_status["male"] and not remove_front:
		#remove_front = true
		#if npcs.size() > 0:
			#npcs.pop_front()

	set_queue_positions(npcs, queue_positions)


func set_queue_positions(npcs, queue_positions):
	for i in range(min(npcs.size(), queue_positions.size())):
		npcs[i].target_position = queue_positions[i].position
		npcs[i].door_pos = male_door.position
		npcs[i].queue_pos = i

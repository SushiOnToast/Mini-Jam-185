extends Node2D

@onready var npc_list: Node2D = $"../NPCs"
var npc_num: int

func _process(delta: float) -> void:
	var npcs = npc_list.get_children()
	npcs.pop_front()
	
	var queue_positions = self.get_children()
	
	for i in range(npcs.size()):
		npcs[i].target_position = queue_positions[i].position
		
	
	
	
	

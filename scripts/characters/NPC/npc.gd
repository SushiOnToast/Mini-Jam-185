extends CharacterBody2D

class_name NPC

@export var target_position: Vector2
@export var door_pos: Vector2
@export var queue_pos: int

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

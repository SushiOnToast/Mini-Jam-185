extends NodeState
class_name NPCWalk

@export var character: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent_2d: NavigationAgent2D
@export var min_speed: float = 5.0
@export var max_speed: float = 10

@onready var npc: NPC = $"../.."

var set_occupied = false

var speed: float
var anim_dir = "down"

func _ready() -> void:
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	
	call_deferred("character_setup")
	
func character_setup() -> void:
	await get_tree().physics_frame
	
	set_movement_target()
	
func set_movement_target() -> void:
	if npc.queue_pos == 0:
		npc.target_position = npc.door_pos
		navigation_agent_2d.target_position = npc.target_position
	speed = randf_range(min_speed, max_speed)
	
func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if navigation_agent_2d.navigation_finished:
		set_movement_target()	
	
	navigation_agent_2d.target_position = npc.target_position
	var target_position: Vector2 = navigation_agent_2d.target_position
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	
	var velocity: Vector2 = target_direction * speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.velocity = velocity
	else:
		character.velocity = target_direction * speed
		character.move_and_slide()
		
	# animation
	var dir = target_direction.normalized()

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			anim_dir = "right"
		else:
			anim_dir = "left"
	else:
		if dir.y > 0:
			anim_dir = "down"
		else:
			anim_dir = "up"
	
	animated_sprite_2d.play("walk_%s" % anim_dir)
	
func on_safe_velocity_computed(safe_velocity: Vector2) -> void:
	character.velocity = safe_velocity
	character.move_and_slide()

func _on_next_transitions() -> void:
	if navigation_agent_2d.is_navigation_finished():
		if npc.queue_pos == 0 and not set_occupied:
			set_occupied = true
			Global.stall_status["male"] = true
			#print("set bathroom status")
			npc.queue_free()
		character.velocity = Vector2.ZERO
		transition.emit("Idle")


func _on_enter() -> void:
	animated_sprite_2d.play("walk_down")


func _on_exit() -> void:
	animated_sprite_2d.stop()

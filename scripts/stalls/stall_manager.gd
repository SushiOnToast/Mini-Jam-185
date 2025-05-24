extends Node2D

@onready var queue_manager: QueueManager = $"../QueueManager"
@onready var stall_timer: Timer = $StallTimer

var set_timer = false

func _process(delta: float) -> void:
	if Global.stall_status["male"] and not set_timer:
		set_timer = true
		stall_timer.start()

func _on_stall_timer_timeout() -> void:
	Global.stall_status["male"] = false
	set_timer = false
	queue_manager.remove_front = false
	
func _on_male_door_body_entered(body: CharacterBody2D) -> void:
	if not Global.stall_status["male"]:
		Global.stall_status["male"] = true
		body.queue_free()
	else:
		print("Occupied!")

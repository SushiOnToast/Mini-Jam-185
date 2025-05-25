extends Node2D

@onready var male_stall_timer: Timer = $MaleStallTimer
@onready var female_stall_timer: Timer = $FemaleStallTimer

var set_male_timer = false
var set_female_timer = false

func _process(delta: float) -> void:
	if Global.stall_status["male"] and not set_male_timer:
		set_male_timer = true
		male_stall_timer.start()
	
	if Global.stall_status["female"] and not set_female_timer:
		set_female_timer = true
		female_stall_timer.start()

func _on_male_stall_timer_timeout() -> void:
	Global.stall_status["male"] = false
	set_male_timer = false
	
func _on_female_stall_timer_timeout() -> void:
	Global.stall_status["female"] = false
	set_female_timer = false
	
func _on_male_door_body_entered(body: NPC) -> void:
	if not Global.stall_status["male"]:
		if body.gender:
			print("wrong toilet!")
		else:
			Global.stall_status["male"] = true
			body.queue_free()
	else:
		print("Occupied!")

func _on_female_door_body_entered(body: NPC) -> void:
	if not Global.stall_status["female"]:
		if !body.gender:
			print("wrong toilet!")
		else:
			Global.stall_status["female"] = true
			body.queue_free()
	else:
		print("Occupied!")

extends Node2D

@onready var male_stall_timer: Timer = $MaleStallTimer
@onready var female_stall_timer: Timer = $FemaleStallTimer

@onready var door_exit_1: Marker2D = $"../NPCExitManager/DoorExit1"
@onready var door_exit_2: Marker2D = $"../NPCExitManager/DoorExit2"

var set_male_timer = false
var set_female_timer = false

var male_user: NPC = null
var female_user: NPC = null

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
	if male_user:
		male_user.position = door_exit_2.position
		male_user.show()
		male_user.used_toilet = true
		male_user = null  # clear reference

func _on_female_stall_timer_timeout() -> void:
	Global.stall_status["female"] = false
	set_female_timer = false
	if female_user:
		female_user.position = door_exit_1.position
		female_user.show()
		female_user.used_toilet = true
		female_user = null  # clear reference
	
func _on_male_door_body_entered(body: NPC) -> void:
	if body.used_toilet:
		return
	if not Global.stall_status["male"]:
		if body.gender:
			print("wrong toilet!")
		else:
			body.hide()
			Global.stall_status["male"] = true
			male_user = body  # store reference
			body.entered_toilet = true
	else:
		print("Occupied!")

func _on_female_door_body_entered(body: NPC) -> void:
	if body.used_toilet:
		return
	if not Global.stall_status["female"]:
		if !body.gender:
			print("wrong toilet!")
		else:
			body.hide()
			Global.stall_status["female"] = true
			female_user = body  # store reference
			body.entered_toilet = true
	else:
		print("Occupied!")

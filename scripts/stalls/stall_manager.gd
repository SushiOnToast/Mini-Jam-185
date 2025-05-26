extends Node2D

@onready var male_stall_timer: Timer = $Timers/MaleStallTimer
@onready var female_stall_timer: Timer = $Timers/FemaleStallTimer

@onready var door_exit_1: Marker2D = $"../NPCExitManager/DoorExit1"
@onready var door_exit_2: Marker2D = $"../NPCExitManager/DoorExit2"

@onready var male_occupied_bubble: Bubble = $Bubbles/MaleOccupiedBubble
@onready var female_occupied_bubble: Bubble = $Bubbles/FemaleOccupiedBubble

@onready var wrong_toilet_male: Bubble = $Bubbles/WrongToiletMale
@onready var wrong_toilet_female: Bubble = $Bubbles/WrongToiletFemale

@onready var needs_toilet_paper_female: Bubble = $Bubbles/NeedsToiletPaperFemale
@onready var needs_toilet_paper_male: Bubble = $Bubbles/NeedsToiletPaperMale

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
		male_user = null
		
		Global.toilet_paper_uses_per_stall["male"] += 1
		if Global.toilet_paper_uses_per_stall["male"] >= Global.MAX_USES_BEFORE_RESTOCK:
			Global.needs_toilet_paper["male"] = true


func _on_female_stall_timer_timeout() -> void:
	Global.stall_status["female"] = false
	set_female_timer = false
	if female_user:
		female_user.position = door_exit_1.position
		female_user.show()
		female_user.used_toilet = true
		female_user = null
		
		Global.toilet_paper_uses_per_stall["female"] += 1
		if Global.toilet_paper_uses_per_stall["female"] >= Global.MAX_USES_BEFORE_RESTOCK:
			Global.needs_toilet_paper["female"] = true

	
func _on_male_door_body_entered(body: NPC) -> void:
	if body.used_toilet:
		return
	if Global.needs_toilet_paper["male"]:
		needs_toilet_paper_male.show_bubble()
		return
	if not Global.stall_status["male"]:
		if body.gender:
			wrong_toilet_male.show_bubble()
		else:
			body.hide()
			Global.stall_status["male"] = true
			male_user = body
			body.entered_toilet = true
	else:
		male_occupied_bubble.show_bubble()


func _on_female_door_body_entered(body: NPC) -> void:
	if body.used_toilet:
		return
	if Global.needs_toilet_paper["female"]:
		needs_toilet_paper_female.show_bubble()
	if not Global.stall_status["female"]:
		if not body.gender:
			wrong_toilet_female.show_bubble()
		else:
			body.hide()
			Global.stall_status["female"] = true
			female_user = body
			body.entered_toilet = true
	else:
		female_occupied_bubble.show_bubble()

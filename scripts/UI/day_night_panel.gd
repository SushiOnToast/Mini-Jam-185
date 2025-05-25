extends Control

@onready var day_label: Label = $DayCounter/DayLabel
@onready var time_label: Label = $Time/TimeLabel
@onready var day_transition_label: Label = $"../DayTransition/Label"
@onready var animation_player: AnimationPlayer = $"../DayTransition/AnimationPlayer"

@export var speed: int = 150

func _ready() -> void:
	if not Global.played_day_one:
		Global.played_day_one = true
		DayAndNightCycleManager.pause()
		animation_player.play("show")
		await animation_player.animation_finished
		animation_player.play_backwards("show")
		DayAndNightCycleManager.resume()
	DayAndNightCycleManager.time_tick.connect(on_time_tick)
	DayAndNightCycleManager.time_tick_day.connect(on_new_day)  # ← connect day change
	DayAndNightCycleManager.game_speed = speed

func on_time_tick(day: int, hour: int, minute: int) -> void:
	time_label.text = "%02d:%02d" % [hour, minute]

func on_new_day(day: int) -> void:
	day_label.text = "Day " + str(day)
	day_transition_label.text = "Day " + str(day)
	DayAndNightCycleManager.pause()
	Global.clear_npcs = true
	animation_player.play("show")
	await animation_player.animation_finished
	animation_player.play_backwards("show")
	DayAndNightCycleManager.resume()
	Global.clear_npcs = false

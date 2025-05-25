extends Control

@onready var day_label: Label = $DayCounter/DayLabel
@onready var time_label: Label = $Time/TimeLabel

@export var speed: int = 100

func _ready() -> void:
	DayAndNightCycleManager.time_tick.connect(on_time_tick)
	DayAndNightCycleManager.time_tick_day.connect(on_new_day)  # ← connect day change
	DayAndNightCycleManager.game_speed = speed

func on_time_tick(day: int, hour: int, minute: int) -> void:
	time_label.text = "%02d:%02d" % [hour, minute]

func on_new_day(day: int) -> void:
	day_label.text = "Day " + str(day)
	print("🌅 A new day has started: Day ", day)

extends Control

@onready var day_label: Label = $DayCounter/DayLabel
@onready var time_label: Label = $Time/TimeLabel

@export var speed: int = 10


func _ready() -> void:
	DayAndNightCycleManager.time_tick.connect(on_time_tick)
	DayAndNightCycleManager.game_speed = speed
	
func on_time_tick(day: int, hour: int, minute: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, minute]

extends Node

const MINUTES_PER_HOUR: int = 60

# Define janitor shift
@export var shift_start_hour: int = 8
@export var shift_end_hour: int = 18

var shift_start_minutes: int
var shift_end_minutes: int
var shift_duration: int

var game_speed: float = 1.0

var current_day: int = 1
var current_minute: int = -1
var time: float = 0.0
var paused: bool = false

signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)

func _ready() -> void:
	shift_start_minutes = shift_start_hour * MINUTES_PER_HOUR
	shift_end_minutes = shift_end_hour * MINUTES_PER_HOUR
	shift_duration = shift_end_minutes - shift_start_minutes
	set_initial_time()

func _process(delta: float) -> void:
	if paused:
		return

	time += delta * game_speed
	game_time.emit(time)
	recalculate_time()

func set_initial_time() -> void:
	time = (current_day - 1) * shift_duration  # Reset to shift start of current day
	current_minute = -1
	recalculate_time()

func recalculate_time() -> void:
	var total_elapsed_minutes: int = int(time)
	var current_day_index: int = int(total_elapsed_minutes / shift_duration)
	
	if current_day_index + 1 != current_day:
		current_day = current_day_index + 1
		Global.spawn_timer_wait_time = max(Global.min_spawn_time, Global.spawn_timer_wait_time - 0.3)
		time = (current_day - 1) * shift_duration  
		current_minute = -1  
		time_tick_day.emit(current_day)

	var shift_time_minutes: int = total_elapsed_minutes % shift_duration
	var total_minutes: int = shift_start_minutes + shift_time_minutes

	var hour: int = int(total_minutes / MINUTES_PER_HOUR)
	var minute: int = total_minutes % MINUTES_PER_HOUR

	if current_minute != minute:
		current_minute = minute
		time_tick.emit(current_day, hour, minute)

# Pause/resume/reset
func reset() -> void:
	current_day = 1
	time = 0.0
	current_minute = -1
	set_initial_time()

func pause() -> void:
	paused = true

func resume() -> void:
	paused = false

func is_paused() -> bool:
	return paused

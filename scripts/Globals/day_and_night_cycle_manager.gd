extends Node

const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60

var game_speed: float = 1.0  # How many in-game minutes pass per real second

var initial_day: int = 1
var initial_hour: int = 0
var initial_minute: int = 0

var time: float = 0.0  # In-game minutes
var current_minute: int = -1
var current_day: int = 0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta * game_speed  # Add real-time * speed to in-game minutes
	game_time.emit(time)
	recalculate_time()

func set_initial_time() -> void:
	time = (initial_day * MINUTES_PER_DAY) + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	current_minute = -1
	current_day = int(time / MINUTES_PER_DAY)
	recalculate_time()

func recalculate_time() -> void:
	var total_minutes: int = int(time)
	var day: int = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute: int = int(current_day_minutes % MINUTES_PER_HOUR)
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day, hour, minute)
		
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)

# === RESET FUNCTION ===
func reset() -> void:
	time = 0.0
	current_minute = -1
	current_day = 0
	set_initial_time()

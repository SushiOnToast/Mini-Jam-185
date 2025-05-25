extends CharacterBody2D

class_name NPC

# === EXPORT VARIABLES ===
@export var target_position: Vector2
@export var door_pos: Vector2
@export var queue_pos: int
@export var angry_time_max: float = 5.0  # Seconds before NPC gets angry
@export var idle = false

# === EXITING LOGIC ===
@export var exit_position: Vector2
var entered_toilet: bool = false
var used_toilet: bool = false
var is_exiting: bool = false

# === NODES ===
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var progress_bar: ProgressBar = $ProgressBar

var gender: int

# === DRAGGING STATE ===
var dragging := false
var offset := Vector2.ZERO

# === ANGRY TIMER STATE ===
var is_waiting: bool = false
var angry_time_left: float = 0.0
var angry_timer_started: bool = false

# === INPUT LOGIC ===
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_try_start_drag()
		else:
			_stop_drag()
	elif event is InputEventMouseMotion and dragging:
		_handle_drag_motion()

func _try_start_drag() -> void:
	if get_global_mouse_position().distance_to(global_position) < 8:
		dragging = true
		offset = global_position - get_global_mouse_position()
		self.scale = Vector2(1.1, 1.1)

func _stop_drag() -> void:
	if dragging:
		dragging = false
		self.scale = Vector2(1, 1)
		# Optional: emit a signal or snap to position

func _handle_drag_motion() -> void:
	global_position = get_global_mouse_position() + offset

# === PROCESS ===
func _process(delta: float) -> void:
	if is_waiting and not entered_toilet:
		_update_angry_timer(delta)

	if idle and not angry_timer_started and not entered_toilet:
		start_angry_timer()
		angry_timer_started = true

# === ANGRY TIMER LOGIC ===
func start_angry_timer() -> void:
	is_waiting = true
	angry_time_left = angry_time_max
	progress_bar.max_value = 100
	progress_bar.value = 100
	progress_bar.visible = true

func _update_angry_timer(delta: float) -> void:
	if entered_toilet:
		stop_angry_timer()
		return

	angry_time_left -= delta
	progress_bar.value = (angry_time_left / angry_time_max) * 100.0
	if angry_time_left <= 0.0:
		_become_angry()

func _become_angry() -> void:
	is_waiting = false
	progress_bar.visible = false
	Global.num_angry += 1
	self.queue_free()
	
func stop_angry_timer() -> void:
	is_waiting = false
	progress_bar.visible = false

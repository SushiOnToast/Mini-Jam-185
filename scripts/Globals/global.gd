extends Node

# player

const PLAYER_SPEED = 100.0
var player_direction = "down"

# stallls

var stall_status: Dictionary = {
	"male": false,
	"female": false
}

var needs_toilet_paper: Dictionary = {
	"male": false,
	"female": false,
}

# Add per-stall usage tracking
var toilet_paper_uses_per_stall := {
	"male": 0,
	"female": 0,
}

# Constants defining usage time and restock variability
const USAGE_TIME_RANGE = {
	"male": Vector2(2.0, 6.0),     # Seconds
	"female": Vector2(3.0, 7.0)
}

const MAX_USES_RANGE = {
	"male": Vector2i(2, 5),
	"female": Vector2i(2, 4)
}

# Track the dynamic max use per stall for restocking
var max_uses_before_restock_per_stall := {
	"male": 3,
	"female": 3
}

func restock_toilet_paper(stall: String) -> void:
	toilet_paper_uses_per_stall[stall] = 0
	needs_toilet_paper[stall] = false


# game state
var toilet_paper_uses := 0
var toilet_paper_depleted := false

signal anger_changed

var num_angry := 0:
	set(value):
		if value != num_angry:
			num_angry = value
			anger_changed.emit()

var spawn_timer_wait_time: float = 7.0
var min_spawn_time = 0.5

var clear_npcs = false

var played_day_one = false

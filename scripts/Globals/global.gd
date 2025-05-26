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

# Max uses before needing a restock
const MAX_USES_BEFORE_RESTOCK = 3

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

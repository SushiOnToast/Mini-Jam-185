extends Node

# player

const PLAYER_SPEED = 100.0
var player_direction = "down"

# stallls

var stall_status: Dictionary = {
	"male": false,
	"female": false
}

# game state

signal anger_changed

var num_angry := 0:
	set(value):
		if value != num_angry:
			num_angry = value
			anger_changed.emit()
			

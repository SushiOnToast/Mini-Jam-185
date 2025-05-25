extends HBoxContainer

@onready var hearts := get_children()

var current_visible := 3  # Starts with full health (3 hearts)

func _ready() -> void:
	Global.anger_changed.connect(update_hearts)
	update_hearts()

func update_hearts() -> void:
	var new_visible = 3 - Global.num_angry
	
	# Only lose hearts, from right to left
	while current_visible > new_visible:
		current_visible -= 1
		var heart = hearts[current_visible]
		heart.animation_player.play("lose")  # Play loss animation
		await heart.animation_player.animation_finished
		heart.hide()

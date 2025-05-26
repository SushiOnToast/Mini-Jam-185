extends Area2D

var player_in_range = false

func _ready():
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))


func _on_Area2D_body_entered(body):
	if body.name == "player":
		player_in_range = true

func _on_Area2D_body_exited(body):
	if body.name == "player":
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("replace_toilet_paper"):
		if Global.toilet_paper_depleted:
			replace_toilet_paper()
		else:
			print("Toilet paper doesn't need replacing.")

func replace_toilet_paper():
	Global.toilet_paper_uses = 0
	Global.toilet_paper_depleted = false
	print("Toilet paper replaced!")

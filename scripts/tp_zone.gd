extends Area2D

@export var teleport_location: NodePath
var can_teleport := false
var player

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "player": # Replace with your player's node name
		can_teleport = true
		player = body

func _on_body_exited(body):
	if body.name == "player":
		can_teleport = false
		player = null

func _process(delta):
	if can_teleport and Input.is_action_just_pressed("interact"):
		if teleport_location and player:
			var destination = get_node(teleport_location)
			player.global_position = destination.global_position

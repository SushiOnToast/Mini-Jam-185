extends Area2D

@export var target_scene_path: String = "res://ScienceRoom.tscn"
@onready var texture_rect: TextureRect = $TextureRect

var player_in_zone := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	texture_rect.visible = player_in_zone
	
	if player_in_zone and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file(target_scene_path)

func _on_body_entered(body):
	if body.name == "Player": # adjust to match your player node name
		player_in_zone = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false

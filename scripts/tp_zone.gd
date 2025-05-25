extends Area2D

@export var target_scene_path: String
@export var target_name: String
@onready var texture_rect: TextureRect = $TextureRect

@onready var state_manager: StateManager = get_tree().get_root().find_child("StateManager", true, false)

var player_in_zone := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _process(delta):
	if self.name.to_lower() == "male":
		if not Global.stall_status["male"]:
			texture_rect.visible = player_in_zone
			
			if player_in_zone and Input.is_action_just_pressed("interact"):
				state_manager.switch_to(target_scene_path, target_name)
		else:
			texture_rect.hi
	elif self.name.to_lower() == "female":
		if not Global.stall_status["female"]:
			texture_rect.visible = player_in_zone
			
			if player_in_zone and Input.is_action_just_pressed("interact"):
				state_manager.switch_to(target_scene_path, target_name)

		else:
			texture_rect.hide()

func _on_body_entered(body):
	if body.name == "Player": # adjust to match your player node name
		player_in_zone = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false

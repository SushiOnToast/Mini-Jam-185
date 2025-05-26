extends Node

class_name StateManager 

@onready var animation_player: AnimationPlayer = $Transition/AnimationPlayer
@onready var main: Main = $".."

var ui_node: Node = null

var prev_scene: Node = null
var prev_scene_path: String = ""

var current_scene: Node = null
var current_scene_path: String
var saved_scenes: Dictionary = {}

var transitioning := false

func is_menu_scene(scene_key: String) -> bool:
	return scene_key in ["StartMenu", "PauseMenu", "GameOver"]

func switch_to(scene_path: String, scene_key: String) -> void:
	if transitioning:
		return
	
	transitioning = true
	animation_player.play("dissolve")
	await animation_player.animation_finished
	
	# Save current scene info before switching
	if current_scene:
		prev_scene = current_scene
		prev_scene_path = current_scene_path
		
		remove_child(current_scene)
		
		# Save only non-menu scenes
		if not is_menu_scene(current_scene.name):
			saved_scenes[current_scene.name] = current_scene
	
	# If it's a menu scene, don't reuse — always instantiate fresh
	if not is_menu_scene(scene_key) and saved_scenes.has(scene_key):
		current_scene = saved_scenes[scene_key]
	else:
		var scene_resource = load(scene_path)
		current_scene = scene_resource.instantiate()
		if not is_menu_scene(scene_key):
			saved_scenes[scene_key] = current_scene
		
	current_scene_path = scene_path
	
	add_child(current_scene)
	animation_player.play_backwards("dissolve")
	await animation_player.animation_finished

	transitioning = false
	
# From your main scene or current active scene

func show_overlay_scene(scene_path: String) -> void:
	var new_scene = load(scene_path).instantiate()
	new_scene.name = "OverlayScene"  # Optional: easy to reference later
	add_child(new_scene)

	# Optional: disable input to the background
	self.set_process_input(false)
	self.set_process_unhandled_input(false)

# To close the overlay scene later
func close_overlay_scene() -> void:
	var overlay = get_node_or_null("OverlayScene")
	if overlay:
		overlay.queue_free()

	# Re-enable input if needed
	self.set_process_input(true)
	self.set_process_unhandled_input(true)
	
func initialize() -> void:
	reset_state()
	ui_node = load("res://scenes/UI/ui.tscn").instantiate()
	add_child(ui_node)
	await switch_to("res://scenes/corridor.tscn", "Corridor")
	
func show_menu() -> void:
	#if ui_node:
		#remove_child(ui_node)
		#ui_node.queue_free()
		#ui_node = null
	switch_to("res://scenes/UI/start_screen.tscn", "StartScreen")

func show_pause() -> void:
	if transitioning or current_scene.name == "StartScreen" or current_scene.name == "GameOverScreen":
		return
	
	DayAndNightCycleManager.pause()
	switch_to("res://scenes/UI/pause_screen.tscn", "PauseScreen")
	
func resume() -> void:
	DayAndNightCycleManager.resume()
	switch_to(prev_scene_path, prev_scene.name)
	
func reset_state():
	for scene in saved_scenes.values():
		scene.queue_free()
	saved_scenes.clear()

	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
		current_scene = null
		current_scene_path = ""
	
	Global.num_angry = 0
	Global.spawn_timer_wait_time = 7.0
	Global.played_day_one = false

	prev_scene = null
	prev_scene_path = ""
	transitioning = false
	
	DayAndNightCycleManager.reset()
	Global.num_angry = 0
	main.shown_game_over = false
	

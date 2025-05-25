extends TextureRect

class_name Bubble

@onready var timer: Timer = $Timer

func _ready() -> void:
	self.hide()
	
func show_bubble():
	if not self.visible:
		self.show()
		timer.start()
	
func _on_timer_timeout() -> void:
	self.hide()

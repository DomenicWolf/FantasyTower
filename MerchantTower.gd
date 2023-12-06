extends AnimatedSprite2D

var is_placed : bool = false
var game_started : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !get_parent()._game_started() and !game_started:
		game_started = true
		$GetMoneyTimer.start()


func _on_get_money_timer_timeout() -> void:
	var Smeckals : Node = get_parent().get_node("HUD").get_node("SmeckalsValue")
	Smeckals.text = str( int(Smeckals.text) + 200 )
	play("money")


func set_is_placed() -> void:
	is_placed = true


func _on_animation_finished() -> void:
	print("test")
	#play("static")


func _on_animation_looped() -> void:
	stop()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if(event.is_action("left_click")):
			print("ytep[]")
			$Popup.position = self.position
			$Popup.show()

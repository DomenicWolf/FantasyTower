extends Area2D

var damage : int = 30
var initial_scale : float = 0.1
var final_scale : float = 3.0
var scale_speed : float = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("attack")
	scale = Vector2(initial_scale, initial_scale)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(4,4), 2)

	#tween.interpolate_value(self, "scale", Vector2(initial_scale, initial_scale), Vector2(final_scale, final_scale), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scale.x >= final_scale:
		queue_free()


func _on_body_entered(body):
	# check if body that enters collison is in group mob_group, then emit hit signal and delete self
	if(body.is_in_group("mob_group")):
		body.emit_signal("hit",damage)
		#queue_free()


func _on_area_entered(area):
	if(area.is_in_group("mob_group") and "Skeleton" not in area.name):
		area.emit_signal("hit",damage)
		#queue_free()

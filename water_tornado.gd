extends Area2D

var damage : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("attack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	# check if body that enters collison is in group mob_group, then emit hit signal and delete self
	if(body.is_in_group("mob_group")):
		body.emit_signal("hit",damage)
		queue_free()


func _on_area_entered(area):
	if(area.is_in_group("mob_group") and "Skeleton" not in area.name):
		area.emit_signal("hit",damage)
		queue_free()

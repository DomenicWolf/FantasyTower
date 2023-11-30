extends Area2D
signal attacking
var has_target : bool = false
var mobs_in_range : Array = []
var time : bool = false
var fire_ball = preload("res://fire_ball.tscn")
@export var is_placed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for mob in mobs_in_range:
		#if mob.is_inside_tree():
		if(mob and time and mob is Node and is_placed):
			attack(mob)
			time = false

func attack(target: Node):
	$AnimatedSprite2D.play()
	
	var new_fire_ball = fire_ball.instantiate()
	add_child(new_fire_ball)
	# interpolate the position of the fireball with the target
	var tween = get_tree().create_tween()
	tween.tween_property(new_fire_ball,"position",(target.global_position - self.global_position) * 3,.4)
	tween.tween_callback(new_fire_ball.queue_free)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#attack(body)
	attacking.emit()
	mobs_in_range.append(body)



func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	$AnimatedSprite2D.stop()
	if(mobs_in_range.find(body) != -1):
		mobs_in_range.remove_at(mobs_in_range.find(body))
	
	

func _on_attack_timer_timeout():
	time = true
	
func set_is_placed():
	is_placed = true



func _on_area_entered(area):
	if ("Skeleton" not in area.name and "Mob" in area.name):
		attacking.emit()
		mobs_in_range.append(area)


func _on_area_exited(area):
	if ("Skeleton" not in area.name and "Mob" in area.name):
		$AnimatedSprite2D.stop()
		if(mobs_in_range.find(area) != -1):
			mobs_in_range.remove_at(mobs_in_range.find(area))
		

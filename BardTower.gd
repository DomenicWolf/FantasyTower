extends Area2D

signal attacking
var has_target : bool = false
var mobs_in_range : Array = []
var time : bool = false
var bard_ring = preload("res://bard_ring.tscn")
@export var is_placed : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for mob in mobs_in_range:
		#if mob.is_inside_tree():
		if(mob and time and mob is Node and is_placed):
			print(2)
			attack(mob)
			time = false

func attack(target: Node):
	$AnimatedSprite2D.play("attack")
	
	var new_bard_ring = bard_ring.instantiate()
	add_child(new_bard_ring)
	new_bard_ring.global_position = global_position
	#var tween = get_tree().create_tween()
	#var direction_to_target = (target.global_position - self.global_position).normalized()
#
	## Set the rotation of the arrow to face the direction
	##new_water_tornado.rotation = direction_to_target.angle()
	## interpolate the position of the fireball with the target
	#tween.tween_property(new_bard_ring,"position",(target.global_position - self.global_position) * 20,1)
	#tween.tween_callback(new_bard_ring.queue_free)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
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
	if ("Skeleton" not in area.name and "Mob" in area.name and "Location" not in area.name):
		attacking.emit()
		mobs_in_range.append(area)


func _on_area_exited(area):
	if ("Skeleton" not in area.name and "Mob" in area.name and "Location" not in area.name):
		$AnimatedSprite2D.stop()
		print(1)
		if(mobs_in_range.find(area) != -1):
			mobs_in_range.remove_at(mobs_in_range.find(area))

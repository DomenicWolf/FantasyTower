extends Area2D
signal attacking
var has_target : bool = false
var mobs_in_range : Array = []
var time : bool = false
var archer_arrow = preload("res://archer_arrow.tscn")
@export var is_placed : bool = false
var mouse_hovered : bool = false
var triple : bool = false
var upgrade_count : int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D/Polygon2D.hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($UpgradePopupContainer/UpgradePopup.visible == true):
		$CollisionShape2D/Polygon2D.show()
	elif !mouse_hovered:
		$CollisionShape2D/Polygon2D.hide()
	$UpgradePopupContainer/UpgradePopup/Sell.text = "Sell:" + (str(upgrade_count * .75))
	for mob in mobs_in_range:
		#if mob.is_inside_tree():
		if(mob and time and mob is Node and is_placed):
			attack(mob)
			time = false

func attack(target: Node):
	$AnimatedSprite2D.play("attack")
	var new_archer_arrow = archer_arrow.instantiate()
	add_child(new_archer_arrow)
	
	var tween = get_tree().create_tween()
	var direction_to_target = (target.global_position - self.global_position).normalized()
	
	var distance = int(target.global_position.distance_to(self.global_position))
	var speed_multi = 100
	
	if distance > 80:
		speed_multi = 30
		print(distance)
	# Set the rotation of the arrow to face the direction
	new_archer_arrow.rotation = direction_to_target.angle()
	if triple:
		var second_arrow = archer_arrow.instantiate()
		var third_arrow = archer_arrow.instantiate()
		add_child(second_arrow)
		add_child(third_arrow)
		var second_tween = get_tree().create_tween()
		var third_tween = get_tree().create_tween()
		
		second_arrow.rotation = direction_to_target.angle() 
		third_arrow.rotation = direction_to_target.angle()
		
		second_tween.tween_property(second_arrow,"position",((target.global_position + Vector2(25,25)) - self.global_position) * speed_multi,1)
		second_tween.tween_callback(second_arrow.queue_free)
		third_tween.tween_property(third_arrow,"position",((target.global_position - Vector2(25,25)) - self.global_position) * speed_multi,1)
		third_tween.tween_callback(third_arrow.queue_free)
	# interpolate the position of the fireball with the target
	tween.tween_property(new_archer_arrow,"position",(target.global_position - self.global_position) * speed_multi,1)
	tween.tween_callback(new_archer_arrow.queue_free)
	
		


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
	if ("Skeleton" not in area.name and "Mob" in area.name and "Location" not in area.name):
		attacking.emit()
		mobs_in_range.append(area)


func _on_area_exited(area):
	if ("Skeleton" not in area.name and "Mob" in area.name and "Location" not in area.name):
		$AnimatedSprite2D.stop()
		print(1)
		if(mobs_in_range.find(area) != -1):
			mobs_in_range.remove_at(mobs_in_range.find(area))

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print(event.as_text())
	if (position.distance_to(event.position) <= 20.0):
		mouse_hovered = true
		$CollisionShape2D/Polygon2D.show()
		if(event.is_action("left_click")):
			$UpgradePopupContainer/UpgradePopup.global_position = Vector2(get_viewport_rect().size.x * 2.8,get_viewport_rect().size.y * 2.7)
			$UpgradePopupContainer/UpgradePopup.show()


	else:
		$CollisionShape2D/Polygon2D.hide()
		mouse_hovered = false




func _on_exit_button_pressed() -> void:
	$UpgradePopupContainer/UpgradePopup.hide()


func _on_faster_shooting_upgrade_pressed() -> void:
	if int(get_parent().get_node("HUD/SmeckalsValue").text) >= 200:
		$UpgradePopupContainer/UpgradePopup/HBoxContainer/FasterShootingUpgrade.disabled = true
		$AttackTimer.wait_time = .3
		get_parent().get_node("HUD/SmeckalsValue").text = str(int(get_parent().get_node("HUD/SmeckalsValue").text) - 200)
		upgrade_count += 200


func _on_longer_range_upgrade_pressed() -> void:
	if int(get_parent().get_node("HUD/SmeckalsValue").text) >= 300:
		$UpgradePopupContainer/UpgradePopup/HBoxContainer2/LongerRangeUpgrade.disabled = true
		$CollisionShape2D.scale.x = 1.5
		$CollisionShape2D.scale.y = 1.5
		get_parent().get_node("HUD/SmeckalsValue").text = str(int(get_parent().get_node("HUD/SmeckalsValue").text) - 300)
		upgrade_count += 300


func _on_triple_arrows_upgrade_pressed() -> void:
	if int(get_parent().get_node("HUD/SmeckalsValue").text) >= 3000:
		$UpgradePopupContainer/UpgradePopup/HBoxContainer2/TripleArrowsUpgrade.disabled = true
		triple = true
		get_parent().get_node("HUD/SmeckalsValue").text = str(int(get_parent().get_node("HUD/SmeckalsValue").text) - 3000)
		upgrade_count += 3000


func _on_button_pressed() -> void:
	get_parent().get_node("HUD/SmeckalsValue").text = str( int(get_parent().get_node("HUD/SmeckalsValue").text) + (upgrade_count * .75) )
	self.queue_free()

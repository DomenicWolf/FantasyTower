extends RigidBody2D

var path_follow : Node
var health : int = 100
signal death
signal point_scored
signal hit
var dead : bool = false
var smeckals : int = 1
var damage : int = 1


@export var _speed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("basic")
	path_follow = self.get_parent()
	add_to_group("mob_group")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Check to see if path_follow is not the window of the game and instead is indeed...
# ... the path node, if so set the progress of the pathfollow
func _physics_process(delta):
	if not "Window" in str(path_follow) and !dead :
		path_follow.progress = (path_follow.progress + _speed * delta)
		path_follow.loop = false
	else:
		pass
		
		
func die():
	death.emit()
	dead = true
	$AnimatedSprite2D.play("death")
	collision_layer = 0
	$DeathTimer.start()
	var smeckals_value = get_parent().get_parent().get_parent().get_node("HUD").get_node("SmeckalsValue")
	smeckals_value.text = str(int(smeckals_value.text) + smeckals)
	
	#collision_mask = 2
	
	
func take_damage(damage: int):
	health = health - damage
	if(health <= 0):
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	point_scored.emit()

	queue_free()

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):

	if(body.has_method("_get_damage")):
		pass



func _on_hit(damage):
	take_damage(damage)


func _on_death_timer_timeout():
	queue_free()
	


func _on_death():
	pass # Replace with function body.

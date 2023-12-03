extends Area2D


var path_follow : Node
var health : int = 400
signal death
signal point_scored
signal hit
var dead : bool = false
var smeckals : int = 5
var damage : int = 3


@export var _speed : int = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("walk")
	path_follow = self.get_parent()
	add_to_group("mob_group")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Check to see if path_follow is not the window of the game and instead is indeed...
# ... the path node, if so set the progress of the pathfollow
func _physics_process(delta: float) -> void:
	if not "Window" in str(path_follow) and !dead :
		path_follow.progress = (path_follow.progress + _speed * delta)
		path_follow.loop = false
	else:
		pass
		
func die() -> void:
	death.emit()
	dead = true
	$AnimatedSprite2D.play("death")
	collision_layer = 0
	$DeathTimer.start()
	var smeckals_value = get_parent().get_parent().get_parent().get_node("HUD").get_node("SmeckalsValue")
	smeckals_value.text = str(int(smeckals_value.text) + smeckals)
	
func take_damage(damage: int) -> void:
	health = health - damage
	if(health <= 0):
		die()
		
func _on_hit(damage: int) -> void:
	take_damage(damage)


func _on_death_timer_timeout() -> void:
	queue_free()
		

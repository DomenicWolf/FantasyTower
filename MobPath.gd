extends Path2D

@export var mob_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
#func _on_mob_timer_timeout():
	## spawn new mob
	#var mob = mob_scene.instantiate()
	## create new pathfollow node ad set rotate to false to stop mob from rotating while 
	##... following the path
	#var mobfollow = PathFollow2D.new()
	#mobfollow.set_rotates(false)
	## get spawn location
	#var mob_spawn_location = get_node("../MobSpawnLocation")
	## set mob position to the position of the mobspawnlocation node
	#mob.global_position = mob_spawn_location.global_position
	#mob.position = mob_spawn_location.global_position
	## add the mob as a child to the mobpathfollow node
	#mobfollow.add_child(mob)
	## add the mobpathfollow as a child to mobpath (self)
	#add_child(mobfollow)
	#mob.global_position = mob_spawn_location.global_position
	#mobfollow.global_position = mob_spawn_location.global_position

	
	

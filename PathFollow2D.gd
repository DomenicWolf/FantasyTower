extends PathFollow2D

@export var mob_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	#spawn new mob
	var mob = mob_scene.instantiate()

	
	#get spawn location
	var mob_spawn_location = get_node("../../MobSpawnLocation")

	#set mob position to the position of the mobspawnlocation node
	mob.position = mob_spawn_location.position
	print(mob.position)
	#add the mob as a child to the mobpathfollow node (self)
	add_child(mob)

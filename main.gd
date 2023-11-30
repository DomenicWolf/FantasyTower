extends Node

@export var mob_scene : PackedScene
@export var knight_scene : PackedScene
@export var goblin_scene : PackedScene
var game_over : bool = true
var current_wave : int = 0
var enemies_per_wave : int = 0
var current_mob_count : int = 0
var round_in_progress : bool = false
var current_round : int = 0
var knight_timer_amount : int = 0
var knight_timer_amount_max : int = 0
var goblin_timer_amount : int = 0
var goblin_timer_amount_max : int = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!get_tree().has_group("mob_group") and !round_in_progress and !game_over):
		round_in_progress = true
		$RoundTimer.start()
	

func new_game():
	_spawn_wave()
	game_over = false

func _on_mob_checkpoint_body_entered(body):
	if(!game_over):
		if(body.is_in_group("mob_group")):
			$HUD/LivesValue.text = str(int($HUD/LivesValue.text) - body.damage)
			body.queue_free()
		if( int($HUD/LivesValue.text) <= 0 ):
			$HUD/GameOver.show()
			game_over = true

func _spawn_wave():
	if(current_round > 3):
		$KnightMobTimer.start()
		knight_timer_amount_max = current_round
		$GoblinMobTimer.start()
		goblin_timer_amount_max = current_round * 2
	if(current_round >= 5):
		pass
	round_in_progress = true
	$RoundTimer.stop()
	$MobTimer.start()
	current_wave += 1
	current_round = int($HUD/Round.text) + 1
	$HUD/Round.text = str( current_round )
	
	enemies_per_wave += 10
	#$RoundTimer.start()

func _on_mob_timer_timeout():
	if (current_mob_count < enemies_per_wave):
			# spawn new mob
		var mob = mob_scene.instantiate()
		# create new pathfollow node ad set rotate to false to stop mob from rotating while 
		#... following the path
		var mobfollow = PathFollow2D.new()
		mobfollow.set_rotates(false)
		# get spawn location
		var mob_spawn_location = $MobSpawnLocation
		# set mob position to the position of the mobspawnlocation node
		mob.global_position = mob_spawn_location.global_position
		mob.position = mob_spawn_location.global_position
		# add the mob as a child to the mobpathfollow node
		mobfollow.add_child(mob)
		# add the mobpathfollow as a child to mobpath 
		$MobPath.add_child(mobfollow)
		mob.global_position = mob_spawn_location.global_position
		mobfollow.global_position = mob_spawn_location.global_position
		current_mob_count += 1
	else:
		$MobTimer.stop()
		round_in_progress = false
		


func _on_round_timer_timeout():
	current_mob_count = 0
	_spawn_wave()


func _on_knight_mob_timer_timeout():
	if (current_mob_count < enemies_per_wave and knight_timer_amount <= knight_timer_amount_max ):
			# spawn new mob
		var knight = knight_scene.instantiate()
		# create new pathfollow node ad set rotate to false to stop mob from rotating while 
		#... following the path
		var mobfollow = PathFollow2D.new()
		mobfollow.set_rotates(false)
		# get spawn location
		var mob_spawn_location = $MobSpawnLocation
		# set mob position to the position of the mobspawnlocation node
		knight.global_position = mob_spawn_location.global_position
		knight.position = mob_spawn_location.global_position
		# add the mob as a child to the mobpathfollow node
		mobfollow.add_child(knight)
		# add the mobpathfollow as a child to mobpath 
		$MobPath.add_child(mobfollow)
		knight.global_position = mob_spawn_location.global_position
		mobfollow.global_position = mob_spawn_location.global_position
		current_mob_count += 1
		knight_timer_amount += 1
	else:
		knight_timer_amount = 0
		$KnightMobTimer.stop()
		round_in_progress = false


func _on_mob_checkpoint_area_entered(area):
		if(!game_over):
			if(area.is_in_group("mob_group")):
				$HUD/LivesValue.text = str(int($HUD/LivesValue.text) - area.damage)
				area.queue_free()
			if( int($HUD/LivesValue.text) <= 0 ):
				$HUD/GameOver.show()
				game_over = true


func _on_goblin_mob_timer_timeout():
	if (current_mob_count < enemies_per_wave and goblin_timer_amount <= goblin_timer_amount_max ):
			# spawn new mob
		var goblin = goblin_scene.instantiate()
		# create new pathfollow node ad set rotate to false to stop mob from rotating while 
		#... following the path
		var mobfollow = PathFollow2D.new()
		mobfollow.set_rotates(false)
		# get spawn location
		var mob_spawn_location = $MobSpawnLocation
		# set mob position to the position of the mobspawnlocation node
		goblin.global_position = mob_spawn_location.global_position
		goblin.position = mob_spawn_location.global_position
		# add the mob as a child to the mobpathfollow node
		mobfollow.add_child(goblin)
		# add the mobpathfollow as a child to mobpath 
		$MobPath.add_child(mobfollow)
		goblin.global_position = mob_spawn_location.global_position
		mobfollow.global_position = mob_spawn_location.global_position
		current_mob_count += 1
		goblin_timer_amount += 1
	else:
		goblin_timer_amount = 0
		$GoblinMobTimer.stop()
		round_in_progress = false

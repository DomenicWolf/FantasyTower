extends CanvasLayer

signal start_game

var clicked_tower : PackedScene
var dragging : bool
var click_radius : int = 50
var durf_tower = preload("res://durf.tscn")
var archer_tower = preload("res://archer_tower.tscn")
var water_wizard_tower = preload("res://water_wizard_tower.tscn")
var bard_tower = preload("res://bard_tower.tscn")
var merchant_tower = preload("res://merchant_tower.tscn")
var IsPlaced : bool = false
var NewTower : Node
var moving : bool = false
var tower : Node
var left : bool = false
var gold_to_remove : int = 0
var map : String = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	print('TEST HELLO')
	$GameOver.hide()
	$SmeckalsLabel.hide()
	$SmeckalsValue.hide()
	$LivesValue.hide()
	$LivesHeart.hide()
	$Background.hide()
	$ArcherButton.hide()
	$WaterWizardButton.hide()
	$MerchantTowerButton.hide()
	$BardTowerButton.hide()
	$Tower1.hide()
	$Round.hide()
	$Background.show()
	$StartButton.hide()
	$SoloRock.hide()
	$Background.play("default")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$Title.hide()
	$StartButton.hide()
	$Background.stop()
	$Background.hide()
	$Background.visible = false
	print($Background.visible)
	$Background.scale = Vector2(0,0)
	$SmeckalsLabel.show()
	$SmeckalsValue.show()
	$LivesValue.show()
	$LivesHeart.show()
	$Background.show()
	$ArcherButton.show()
	$WaterWizardButton.show()
	$MerchantTowerButton.show()
	$BardTowerButton.show()
	$Tower1.show()
	$Round.show()
	$SoloRock.hide()
	start_game.emit()



func _on_tower_1_pressed():
	pass # Replace with function body.
	

func _on_tower_1_button_down():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = durf_tower
		gold_to_remove = 200
		#$SmeckalsValue.text = str(int($SmeckalsValue.text) - 200)
		tower = $Tower1
	else:
		clicked_tower = null
	

func _input(event):
	# check if event is an mousebutton event, check what mouse button, check if event is on button...
	#... check if event is currently pressed to enable dragging...
	#... if dragging is true but button was released, end dragging
	if event is InputEventMouseButton and clicked_tower:
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			if(event.position - tower.position).length() < click_radius:
				if event.pressed:
					left = true
					dragging = true
			if dragging and not event.pressed:
				dragging = false
				moving = false
				NewTower.set_is_placed()
				$SmeckalsValue.text = str(int($SmeckalsValue.text) - gold_to_remove)
	# if dragging is true and event is mouse moving, check if isplaced is false and moving is false
	#... create new durf tower
	if dragging and event is InputEventMouseMotion and clicked_tower and left:
		if(not IsPlaced and not moving):
			NewTower = clicked_tower.instantiate()
			moving = true
			NewTower.visible = false
			get_node("../../Main").add_child(NewTower)
		elif(not IsPlaced and moving):
			NewTower.visible = true
			NewTower.position = event.position
		#else:
			#print(44)
			#NewTower.set_is_placed()
			#moving = false
			#left = false
			

		


func _on_archer_button_button_down():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = archer_tower
		gold_to_remove = 200
		#$SmeckalsValue.text = str(int($SmeckalsValue.text) - 200)
		tower = $ArcherButton
	else:
		clicked_tower = null
	


func _on_archer_button_mouse_entered():
	if int($SmeckalsValue.text) >= 200:
		tower = $ArcherButton
		clicked_tower = archer_tower


func _on_tower_1_mouse_entered():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = durf_tower
		tower = $Tower1

	


func _on_water_wizard_button_button_down():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = water_wizard_tower
		gold_to_remove = 200
		#$SmeckalsValue.text = str(int($SmeckalsValue.text) - 200)
		tower = $WaterWizardButton
	else:
		clicked_tower = null


func _on_water_wizard_button_mouse_entered():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = water_wizard_tower
		tower = $WaterWizardButton


func _on_bard_tower_button_button_down():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = bard_tower
		gold_to_remove = 200
		#$SmeckalsValue.text = str(int($SmeckalsValue.text) - 200)
		tower = $BardTowerButton
	else:
		clicked_tower = null


func _on_bard_tower_button_mouse_entered():
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = bard_tower
		tower = $BardTowerButton


func _on_merchant_tower_button_button_down() -> void:
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = merchant_tower
		gold_to_remove = 200
		#$SmeckalsValue.text = str(int($SmeckalsValue.text) - 200)
		tower = $MerchantTowerButton
	else:
		clicked_tower = null


func _on_merchant_tower_button_mouse_entered() -> void:
	if int($SmeckalsValue.text) >= 200:
		clicked_tower = merchant_tower
		tower = $MerchantTowerButton


func _on_solo_pressed() -> void:
	$StartButton.show()
	$Solo.hide()
	$Online.hide()
	$SoloRock.show()

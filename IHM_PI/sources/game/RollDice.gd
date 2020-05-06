extends Node2D
enum {DAMAGE_1 =1,DAMAGE_2=2,HEAL=3,GATTLING=4,ARROW=5,BOMB=6 }
var WindowSizes=OS.get_real_window_size() #if needed



const MAXTHROWS =4 
var nbr_throws =0
var RollDiceButton # Button to be clicked to roll the dices
var EndTurnButton # Button to be clicked to end the turn
var RollingBool= false # Boolean to verify the Dices are rolling
var label_login_name

#install Timer for the dice switch
var RollTimer

var button_on_off = 0
#0 = on, can throw dices
#1 = off, cannot throw dices


# image variables loaded so that we don´t need reload everytime
var DMG1_IMG = load("res://imgs/DMG1.png")
var DMG2_IMG=load("res://imgs/DMG2.png")
var HEAL_IMG=load("res://imgs/Biere.png")
var GATTLING_IMG=load("res://imgs/Gattline.png")
var ARROW_IMG=load("res://imgs/fleche.png")
var BOMB_IMG=load("res://imgs/Dynamite.png")

#Booleans to check if a Button was clicked
var Dice1Clicked=false
var Dice2Clicked=false
var Dice3Clicked=false
var Dice4Clicked=false
var Dice5Clicked=false

# When the program is launched the Dices and DiceTab is initialized
onready var Dice_container = init_dice_tab()
onready var Dice1 = Dice_container.get_child(0).get_child(1)
onready var Dice2 = Dice_container.get_child(1).get_child(1)
onready var Dice3 = Dice_container.get_child(2).get_child(1)
onready var Dice4 = Dice_container.get_child(3).get_child(1)
onready var Dice5 = Dice_container.get_child(4).get_child(1)


func _set_disabled():
	$Button.disabled = true
	$Button.modulate = Color(0.5,0.5,0.5,1)
	$Button/sprite_itemIcon.modulate = Color(0.25,0.25,0.25)

func print_label():
	label_login_name = Label.new()
	label_login_name.set_name("label_login_name")
	label_login_name.text = global.dico_alias[global.current_player.to_str()]
	label_login_name.set_position(Vector2(500, 250))


############################## Styles for RollDiceButton and EndTurnButton##############################
func set_style_for_buttons(butt):
	
	butt.expand_icon = true
	butt.set_size(Vector2(88,50))
	
	#Styles for my button and empty the focus
	var normal = StyleBoxFlat.new()
	var empty = StyleBoxEmpty.new()
	var hover = StyleBoxFlat.new()
	var pressed = StyleBoxFlat.new()
	
	# Normal style
	normal.set_bg_color(Color(0.6,0.6,0.6,0))
	normal.set_border_width_all(3)
	normal.set_border_color(Color(0,0,0,1))
	normal.set_corner_radius_all(3)
	normal.border_blend = true
	
	# Hover style
	hover.set_bg_color(Color(0.6,0.6,0.6,0))
	hover.set_border_width_all(3)
	hover.set_border_color(Color(0,0,0,1))
	hover.set_corner_radius_all(3)
	hover.border_blend = true
	
	# Pressed style
	pressed.set_bg_color(Color(0.6,0.6,0.6,0))
	pressed.set_border_width_all(2)
	pressed.set_border_color(Color(0,0,0,1))
	pressed.set_corner_radius_all(3)
	pressed.border_blend = true
	
	butt.set('custom_styles/normal', normal)
	butt.set('custom_styles/focus', empty) # Stay Empty
	butt.set('custom_styles/hover', hover)
	butt.set('custom_styles/pressed', pressed)

#######################################################################################################

#Initialize de RollDiceButton and EndTurnButton
#Return: None
func init_RollDicebutton_and_EndTurnButton():
	
	#Roll Button
	RollDiceButton = Button.new()
	RollDiceButton.set_name("RollDiceButton")
	RollDiceButton.text = "Roll my dices"
	# You can use set_style_for_buttons for all changes for a button
	# But unfortunately there is a problem when sending to the network side
#	set_style_for_buttons(RollDiceButton)
	RollDiceButton.set_button_icon(load("res://imgs/rolldice.png"))
	RollDiceButton.set_position(Vector2(733,356))
	RollDiceButton.set_size(Vector2(88,50))

	RollDiceButton.disabled = false
	button_on_off = 0
	
	#End turn Button
	EndTurnButton = Button.new()
	EndTurnButton.set_name("EndTurnButton")
	EndTurnButton.text = "End my turn"
#	set_style_for_buttons(EndTurnButton)
#	EndTurnButton.set_button_icon(load("res://imgs/effect.png")) 
	EndTurnButton.set_position(Vector2(488,356))
	EndTurnButton.set_size(Vector2(88,50))
	
	#Connect them to a function if they are clicked
	RollDiceButton.connect("pressed", self, "RollDiceButton_clicked")
	EndTurnButton.connect("pressed", self, "EndTurnButton_clicked")
	#Add the buttons as children of the body
	self.add_child(RollDiceButton)
	self.add_child(EndTurnButton)


#Function called when the RollDiceButton is clicked
#Return: None
func RollDiceButton_clicked():
	if button_on_off == 0:
		RollDiceButton.disabled = true
		button_on_off = 1
		nbr_throws+=1
		if nbr_throws < MAXTHROWS:
			RollingBool=true
			# Making the timer to stop the rolling of the Dices
			RollTimer.connect("timeout",self,"on_RollTimer_Timeout", [], CONNECT_ONESHOT)
			RollTimer.start()
			RollTimer.set_wait_time(2)
		else:
			#RollDiceButton.disabled = true
			print("You can´t throw anymore")
	
	
#Function called by the Rolltimer so that the Rolling of the Dices ends
func on_RollTimer_Timeout():
	if nbr_throws != MAXTHROWS-1:
		button_on_off = 0
		RollDiceButton.disabled = false
	RollTimer.stop()
	RollingBool=false
	

#Function called when the EndTurnButton is clicked (TODO)
#Return: None
func EndTurnButton_clicked():
	print("We change player")
	print("now playing with player " + str(global.get_current_player))
	button_on_off = 0
	RollDiceButton.disabled = false
	global.get_current_player = (global.get_current_player + 1) % 4
	

#Initialisation of the dice
#Return: Dice container
func init_dice_tab():
	
	#initialization of the Container of the dices
	var HsplitContainer = HSplitContainer.new()
	self.add_child(HsplitContainer)
	
	#Variables
	var AreaDice # area to make it possible to click the dice
	var DiceBackground # White background
	var DiceValImg # img of the dice
	var CollisionshapeDice # shape to be click the dice
	var k # variable to make a selection of 1 to 6 rather than 0 to 5
	
	#set space position of HsplitContainer
	HsplitContainer.set_position(Vector2(450,314))
	HsplitContainer.set_size(Vector2(482,64))

	#Loop to create the dices, children of HsplitContainer
	for i in range(0,5):
		k = i+1
		
		#create area
		AreaDice = Area2D.new()
		AreaDice.set_name("DiceArea2D_" + str(k))
		
		#create the sprite 'dice background'
		DiceBackground = Sprite.new()
		DiceBackground.set_name("DiceBackground_" + str(k))
		DiceBackground.texture = load("res://imgs/des.png")
		DiceBackground.scale.x = 0.10
		DiceBackground.scale.y = 0.10
		
		
		
		#add the sprite 'value of the dice'
		DiceValImg = Sprite.new()
		DiceValImg.set_name("DiceVal_" + str(k))
		DiceValImg.texture = load("res://imgs/DMG1.png")
		DiceValImg.scale.x = 0.10
		DiceValImg.scale.y = 0.10
		
		#add Collisionshape to the Dice (so that we can touch it)
		CollisionshapeDice = CollisionShape2D.new()
		CollisionshapeDice.set_name("CollisionshapeDice_" + str(k))
		CollisionshapeDice.scale.x = 0.10
		CollisionshapeDice.scale.y = 0.10	
		
		#add children to this area (the order has to be respected)
		
		HsplitContainer.add_child(AreaDice)
		AreaDice.add_child(DiceBackground)
		AreaDice.add_child(DiceValImg)
		AreaDice.add_child(CollisionshapeDice)
		
		AreaDice.position += Vector2(k*70 ,0)
	
	return HsplitContainer

# Makes the Image of the dice switch randomly (graphical) and stops at the core 
# value of the Dice (core)
#Return: None
func change_img(Dice):
	var NewValueOfDice
	NewValueOfDice = floor(rand_range(1,7))	
	#select the respective image depending on the value
	if NewValueOfDice == DAMAGE_1: # Damage 1
		Dice.texture = DMG1_IMG	
			
	elif NewValueOfDice == DAMAGE_2: #Damage 2
		Dice.texture= DMG2_IMG
			
	elif NewValueOfDice == HEAL:# Heal
		Dice.texture = HEAL_IMG
			
	elif NewValueOfDice == GATTLING:# Gattling
		Dice.texture = GATTLING_IMG
			
	elif NewValueOfDice == ARROW:# Arrow
		Dice.texture = ARROW_IMG
			
	elif NewValueOfDice == BOMB:# DYNAMITE
		Dice.texture = BOMB_IMG

func _ready():
	init_RollDicebutton_and_EndTurnButton()
	RollDiceButton=self.get_child(2)
	EndTurnButton=self.get_child(3)
	RollTimer=Timer.new()
	print_label()
	
	self.add_child(RollTimer)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if RollingBool==true: # the Dices are rolling
		change_img(Dice1)
		change_img(Dice2)
		change_img(Dice3)
		change_img(Dice4)
		change_img(Dice5)
	
	pass

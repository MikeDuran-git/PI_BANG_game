extends Node2D

var _player

var image_enlarged = 0

const scale_up = 0.3
const scale_base = 0.04

var image1_big = 0 #SHERIF
var node_image1 = 0
const image1x = 577
const image1y = 0

var image2_big = 0
const image2x = 450
const image2y = 260

var image3_big = 0
const image3x = 0
const image3y = 290

var image4_big = 0
const image4x = -450
const image4y = 260

var image5_big = 0
const image5x = -577
const image5y = 0

var image6_big = 0
const image6x = -450
const image6y = -260

var image7_big = 0
const image7x = 0
const image7y = -290

var image8_big = 0
const image8x = 450
const image8y = -260

var normal_size_sprite = 0.04
var big_size_sprite = 0.4
var old_pos_x
var old_pos_y

var new_pos_x = 0.24
var new_pos_y = 3.4

var nbrPlayer= global.NUMBER_OF_PLAYER
# ihmlife[i] = $iconei which is the node corresponding to the i-player hp 
#use change_ihm_life to update the ihm hp of a player
var ihm_life = []
var current_player

var TEST_ihm_life=[]

var label_life = ""
var label_arrow = ""

onready var lblife1 = $Table/label_life_player1
onready var lbarrow1 = $Table/label_arrow_player1

onready var lblife2 = $Table/label_life_player2
onready var lbarrow2 = $Table/label_arrow_player2

onready var lblife3 = $Table/label_life_player3
onready var lbarrow3 = $Table/label_arrow_player3

onready var lblife4 = $Table/label_life_player4
onready var lbarrow4 = $Table/label_arrow_player4

onready var lblife5 = $Table/label_life_player5
onready var lbarrow5 = $Table/label_arrow_player5

onready var lblife6 = $Table/label_life_player6
onready var lbarrow6 = $Table/label_arrow_player6

onready var lblife7 = $Table/label_life_player7
onready var lbarrow7 = $Table/label_arrow_player7

onready var lblife8 = $Table/label_life_player8
onready var lbarrow8 = $Table/label_arrow_player8

onready var lbarrow0 = $Table/label_arrow_player0


var Player_icon_width_height=0.8
var Player_icon_initial_img=load("res://imgs/2.png")

onready var button_leave = $button_leave_game
onready var popup_leave = $popup_leave_game



func init_Player_Style():
	pass
# return img corresponding to a amount of hp
func hp_to_img(life):
	var path = ""
	match(life):
		1 : path="res://imgs/1.png"
		2 : path="res://imgs/2.png"
		3 : path="res://imgs/3.png"
		4 : path="res://imgs/4.png"
		5 : path="res://imgs/5.png"
		6 : path="res://imgs/6.png"
		7 : path="res://imgs/7.png"
		8 : path="res://imgs/8.png"
		9 : path="res://imgs/9.png"
		10 : path="res://imgs/10.png"
		11 : path="res://imgs/11.png"
		12 : path="res://imgs/12.png"
		13 : path="res://imgs/13.png"
	return path
	
func change_img_life(position,new_hp):
	ihm_life[position].texture = load(hp_to_img(new_hp)) 
	pass

func hide_graphic_player(number):
	if number==8:
		$Table/Perso6.hide()
		$Table/label_name_p6.hide()
		$Table/sprite_heart_life6.hide()
		$Table/label_life_player6.hide()
		$Table/sprite_arrow_arrows6.hide()
		$Table/label_arrow_player6.hide()
	if number==7:
		$Table/Perso7.hide()
		$Table/label_name_p7.hide()
		$Table/sprite_heart_life7.hide()
		$Table/label_life_player7.hide()
		$Table/sprite_arrow_arrows7.hide()
		$Table/label_arrow_player7.hide()
	if number==6:
		$Table/Perso8.hide()
		$Table/label_name_p8.hide()
		$Table/sprite_heart_life8.hide()
		$Table/label_life_player8.hide()
		$Table/sprite_arrow_arrows8.hide()
		$Table/label_arrow_player8.hide()
	if number==5:
		$Table/Perso5.hide()
		$Table/label_name_p5.hide()
		$Table/sprite_heart_life5.hide()
		$Table/label_life_player5.hide()
		$Table/sprite_arrow_arrows5.hide()
		$Table/label_arrow_player5.hide()
	if number==4:
		$Table/Perso4.hide()
		$Table/label_name_p4.hide()
		$Table/sprite_heart_life4.hide()
		$Table/label_life_player4.hide()
		$Table/sprite_arrow_arrows4.hide()
		$Table/label_arrow_player4.hide()
	if number==3:
		$Table/Perso3.hide()
		$Table/label_name_p3.hide()
		$Table/sprite_heart_life3.hide()
		$Table/label_life_player3.hide()
		$Table/sprite_arrow_arrows3.hide()
		$Table/label_arrow_player3.hide()
	if number==2:
		$Table/Perso2.hide()
		$Table/label_name_p2.hide()
		$Table/sprite_heart_life2.hide()
		$Table/label_life_player2.hide()
		$Table/sprite_arrow_arrows2.hide()
		$Table/label_arrow_player2.hide()
	if number==1:
		$Table/SHERIF.hide()
		$Table/label_name_p1.hide()
		$Table/sprite_heart_life.hide()
		$Table/label_life_player1.hide()
		$Table/sprite_arrow_arrows.hide()
		$Table/label_arrow_player1.hide()
	pass
	
func Player_init(nbr_Player):
	for _i in range(0,nbr_Player):
		ihm_life.append(null)
		TEST_ihm_life.append(null)
	for i in range(0,nbr_Player):
		ihm_life[i]=get_node(str("Table/icon",i+1))
		ihm_life[i].scale.x=Player_icon_width_height
		ihm_life[i].scale.y=Player_icon_width_height
	for i in range(8,global.NUMBER_OF_PLAYER):
		ihm_life[i].hide()
	
	
func design_player(nbr_player):
	for i in range(0,nbr_player):
		ihm_life[i]=change_img_life(i, TEST_ihm_life[i])

# Called when the node enters the scene tree for the first time.
signal ASSOCIATE_ROLE

var my_timer
func _ready():
	my_timer = Timer.new()
	my_timer.set_name("my_timer")
	add_child(my_timer)
	#launch music
	
	#print("global.current_player is " + str(global.current_player))
	lblife1.text = label_life + str(global.life1)
	lblife2.text = label_life + str(global.life2)
	lblife3.text = label_life + str(global.life3)
	lblife4.text = label_life + str(global.life4)
	lblife5.text = label_life + str(global.life5)
	lblife6.text = label_life + str(global.life6)
	lblife7.text = label_life + str(global.life7)
	lblife8.text = label_life + str(global.life8)
	
	lbarrow1.text = label_arrow + str(global.arrow1)
	lbarrow2.text = label_arrow + str(global.arrow2)
	lbarrow3.text = label_arrow + str(global.arrow3)
	lbarrow4.text = label_arrow + str(global.arrow4)
	lbarrow5.text = label_arrow + str(global.arrow5)
	lbarrow6.text = label_arrow + str(global.arrow6)
	lbarrow7.text = label_arrow + str(global.arrow7)
	lbarrow8.text = label_arrow + str(global.arrow8)
	
	
	if global.is_playing == 0:
		# Music at the start of the game
		get_node("HSlider/GameplayMusic").play()
#		
		
		Player_init(global.NUMBER_OF_PLAYER)
		for i in range (0,global.NUMBER_OF_PLAYER):
			TEST_ihm_life[i]=i+1
		design_player(global.NUMBER_OF_PLAYER)
		global.is_playing = 1
	if global.NUMBER_OF_PLAYER==7:
		hide_graphic_player(8)
	if global.NUMBER_OF_PLAYER==6:
		hide_graphic_player(8)
		hide_graphic_player(7)
	if global.NUMBER_OF_PLAYER==5:
		hide_graphic_player(8)
		hide_graphic_player(7)
		hide_graphic_player(6)
	if global.NUMBER_OF_PLAYER==4:
		hide_graphic_player(8)
		hide_graphic_player(7)
		hide_graphic_player(6)
		hide_graphic_player(5)

	global.game_is_playing=true
	
	# the signal when the ENDTURN BUTTON was clicked
	$Table/RollDice.connect("ACTIVATE_EFFECT_SIGNAL",self,"READING_DICE_EFFECT",[],CONNECT_PERSIST)		
	global.connect("CHANGE_DICE",self,"CHANGE_DICE_FUNCTION",[global.dice_array_img_for_rolldice_after_timeout],CONNECT_PERSIST)
	self.connect("ASSOCIATE_ROLE",self,"ASSOCIATE_ROLE_FUNCTION",[global.msg_of_server],CONNECT_PERSIST)
	global.connect("show_ROLLDICE_ENDTURNBUTTON",self,"show_ROLLDICE_ENDTURNBUTTON_FUNCTION",[],CONNECT_PERSIST)
	global.connect("hide_ROLLDICE_ENDTURNBUTTON",self,"hide_ROLLDICE_ENDTURNBUTTON_FUNCTION",[],CONNECT_PERSIST)
	global.connect("dynamites",self,"dynamite_FUCNTION")
	global.connect("DEAD_PLAYERS",self,"DEAD_PLAYERS_FUNCTION",[],CONNECT_PERSIST)
	global.connect("EFFECT_RECEIVED",self,"effect_confirmation",[],CONNECT_PERSIST)
	global.connect("VICTORY_MSG",self,"VictoryScreen")
	$Victory/ContinueButton.connect("QUIT_GAME_SIGNAL",self,"exit_game")
	#global.connect("ENDGAME",self,"ENDGAME_FUNCTION",[],CONNECT_PERSIST)
	#emit_signal("ASSOCIATE_ROLE")
	pass

func _process(delta):
	if global.ASSOSIATE_ROLE_variable==1:
		print("signal role affected")
		emit_signal("ASSOCIATE_ROLE")
		global.ASSOSIATE_ROLE_variable=0
		
	if global.show_rolldicebutton_and_ENDTURNButton_variable==true:
		if global.dynamite_variable==0:
			$Table/RollDice.RollDiceButton.visible=true
		else:
			$Table/RollDice.RollDiceButton.visible=false
			$Table/RollDice.hide_buttons()
		$Table/RollDice.EndTurnButton.visible=true
	else:
		$Table/RollDice.RollDiceButton.visible=false
		$Table/RollDice.EndTurnButton.visible=false
		$Table/RollDice.hide_buttons()
	
	pass
	
func dynamite_FUCNTION():
	pass

func exit_game():
	print("QUIT_GAME_SIGNAL catched ")
	get_tree().change_scene("res://sources/menu/Menu.tscn")
	pass
	
func set_server_Dice_img(Dice,value):
	if value == '1':
		Dice.texture=$Table/RollDice.DMG1_IMG
	if value == '2':
		Dice.texture=$Table/RollDice.DMG2_IMG
	if value == 'b':
		Dice.texture=$Table/RollDice.HEAL_IMG
	if value == 'g':
		Dice.texture=$Table/RollDice.GATTLING_IMG
	if value == 'd':
		Dice.texture=$Table/RollDice.BOMB_IMG
	if value == 'a':
		Dice.texture=$Table/RollDice.ARROW_IMG
	pass

func set_role(role):
	var result
	if role=="sherif":
		result = preload("res://imgs/cartes_role/Sherif.png")
	if role=="renegat":
		result = preload("res://imgs/cartes_role/Renegat.png")
	if role=="hors-la-loi":
		result = preload("res://imgs/cartes_role/HorsLaLoi.png")
	if role=="adjoint":
		result = preload("res://imgs/cartes_role/Adjoint.png")
	if role=="unknown":
		result   = preload("res://imgs/question-mark-cover.jpg")
	return result

func set_role_to_player(idplayer,rolename):
	if idplayer=="0":
		$Table/Role_player1.texture=set_role(rolename)
		$Table/Role_player1.scale=Vector2(0.087,0.12)
		pass
	if idplayer=="1":
		$Table/Role_player2.texture=set_role(rolename)
		$Table/Role_player2.scale=Vector2(0.087,0.12)
		pass
	if idplayer=="2":
		$Table/Role_player3.texture=set_role(rolename)
		$Table/Role_player3.scale=Vector2(0.087,0.12)
		pass
	if idplayer=="3":
		$Table/Role_player4.texture=set_role(rolename)
		$Table/Role_player4.scale=Vector2(0.087,0.12)
		pass
	if global.NUMBER_OF_PLAYER==8:
		if idplayer=="4":
			$Table/Role_player5.texture=set_role(rolename)
			$Table/Role_player5.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="5":
			$Table/Role_player6.texture=set_role(rolename)
			$Table/Role_player6.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="6":
			$Table/Role_player7.texture=set_role(rolename)
			$Table/Role_player7.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="7":
			$Table/Role_player8.texture=set_role(rolename)
			$Table/Role_player8.scale=Vector2(0.087,0.12)
			pass
		
		pass
	if global.NUMBER_OF_PLAYER==7:
		if idplayer=="4":
			$Table/Role_player5.texture=set_role(rolename)
			$Table/Role_player5.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="5":
			$Table/Role_player6.texture=set_role(rolename)
			$Table/Role_player6.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="6":
			$Table/Role_player7.texture=set_role(rolename)
			$Table/Role_player7.scale=Vector2(0.087,0.12)
			pass	
		pass
	if global.NUMBER_OF_PLAYER==6:
		if idplayer=="4":
			$Table/Role_player5.texture=set_role(rolename)
			$Table/Role_player5.scale=Vector2(0.087,0.12)
			pass
		
		if idplayer=="5":
			$Table/Role_player6.texture=set_role(rolename)
			$Table/Role_player6.scale=Vector2(0.087,0.12)
			pass

		pass
	if global.NUMBER_OF_PLAYER==5:
		if idplayer=="4":
			$Table/Role_player5.texture=set_role(rolename)
			$Table/Role_player5.scale=Vector2(0.087,0.12)
			pass
		pass
	pass
	pass

func set_character(charname):
	if charname=="sid ketchum":
		var SidKetchum   = preload("res://imgs/carte_personnage/carte_perso_1.png")
		return SidKetchum
		pass
	if charname=="black jack":
		var BlackJack    = preload("res://imgs/carte_personnage/carte_perso_2.png")
		return BlackJack
		pass
	if charname=="pedro ramirez":
		var PedroRamirez = preload("res://imgs/carte_personnage/carte_perso_3.png")
		return PedroRamirez
		pass
	if charname=="kit carlson":
		var KitCarlson   = preload("res://imgs/carte_personnage/carte_perso_4.png")
		return KitCarlson
		pass
	if charname=="bart cassidy":
		var BartCassidy  = preload("res://imgs/carte_personnage/carte_perso_5.png")
		return BartCassidy
		pass
	if charname=="willy the kid":
		var WillyTheKid  = preload("res://imgs/carte_personnage/carte_perso_6.png")
		return WillyTheKid
		pass
	if charname=="slab the killer":
		var SlabTheKiller= preload("res://imgs/carte_personnage/carte_perso_8.png")
		return SlabTheKiller
		pass
	if charname=="jourdonnais":
		var Jourdonnais  = preload("res://imgs/carte_personnage/carte_perso_9.png")
		return Jourdonnais
		pass
	if charname=="el gringo":
		var ElGringo     = preload("res://imgs/carte_personnage/carte_perso_10.png")
		return ElGringo
		pass
	if charname=="paul regret":
		var PaulRegret   = preload("res://imgs/carte_personnage/carte_perso_11.png")
		return PaulRegret
		pass
	if charname=="lucky duke":
		var LuckyDuke    = preload("res://imgs/carte_personnage/carte_perso_12.png")
		return LuckyDuke
		pass
	if charname=="suzy lafayette":
		var SuzyLafayette= preload("res://imgs/carte_personnage/carte_perso_13.png")
		return SuzyLafayette
		pass
	if charname=="vulture sam":
		var VultureSam   = preload("res://imgs/carte_personnage/carte_perso_14.png")
		return VultureSam
		pass
	if charname=="rose doolan":
		var RoseDoolan   = preload("res://imgs/carte_personnage/carte_perso_15.png")
		return RoseDoolan
		pass
	if charname== "jesse jones":
		var JesseJones   = preload("res://imgs/carte_personnage/carte_perso_7.png")
		return JesseJones
	pass

func set_character_to_player(idplayer,charname):
	if idplayer=="id0":
		$Table/SHERIF.texture=set_character(charname)
		pass
	if idplayer=="id1":
		$Table/Perso2.texture=set_character(charname)
		pass
	if idplayer=="id2":
		$Table/Perso3.texture=set_character(charname)
		pass
	if idplayer=="id3":
		$Table/Perso4.texture=set_character(charname)
		pass
	if global.NUMBER_OF_PLAYER==8:
		if idplayer=="id4":
			$Table/Perso5.texture=set_character(charname)
			pass
		
		if idplayer=="id5":
			$Table/Perso8.texture=set_character(charname)
			pass
		
		if idplayer=="id6":
			$Table/Perso7.texture=set_character(charname)
			pass
		
		if idplayer=="id7":
			$Table/Perso6.texture=set_character(charname)
			pass
		
		pass
	if global.NUMBER_OF_PLAYER==7:
		if idplayer=="id4":
			$Table/Perso5.texture=set_character(charname)
			pass
		
		if idplayer=="id5":
			$Table/Perso8.texture=set_character(charname)
			pass
		
		if idplayer=="id6":
			$Table/Perso7.texture=set_character(charname)
			pass	
		pass
	if global.NUMBER_OF_PLAYER==6:
		if idplayer=="id4":
			$Table/Perso5.texture=set_character(charname)
			pass
		
		if idplayer=="id5":
			$Table/Perso8.texture=set_character(charname)
			pass

		pass
	if global.NUMBER_OF_PLAYER==5:
		if idplayer=="id4":
			$Table/Perso5.texture=set_character(charname)
			pass
		pass
	pass

func set_dead(idplayer,answer):
	if idplayer=="0":
		if answer!='no':
			$Table/tomb_player1.show()
			$Table/Role_player1.texture=set_role(answer)
			hide_graphic_player(1)
			pass
		pass
	if idplayer=="1":
		if answer!='no':
			$Table/tomb_player2.show()
			$Table/Role_player2.texture=set_role(answer)
			hide_graphic_player(2)
		pass
	if idplayer=="2":
		if answer!='no':
			$Table/tomb_player3.show()
			$Table/Role_player3.texture=set_role(answer)
			hide_graphic_player(3)
		pass
	if idplayer=="3":
		if answer!='no':
			$Table/tomb_player4.show()
			$Table/Role_player4.texture=set_role(answer)
			hide_graphic_player(4)
		pass
	if global.NUMBER_OF_PLAYER==8:
		if idplayer=="4":
			if answer!='no':
				$Table/tomb_player5.show()
				$Table/Role_player5.texture=set_role(answer)
				hide_graphic_player(5)		
			pass
		
		if idplayer=="5":
			if answer!='no':
				$Table/tomb_player6.show()
				$Table/Role_player6.texture=set_role(answer)
				hide_graphic_player(6)
			pass
		
		if idplayer=="6":
			if answer!='no':
				$Table/tomb_player7.show()
				$Table/Role_player7.texture=set_role(answer)
				hide_graphic_player(7)
			pass
		
		if idplayer=="7":
			if answer!='no':
				$Table/tomb_player8.show()
				$Table/Role_player8.texture=set_role(answer)
				hide_graphic_player(8)
			pass
		
		pass
	if global.NUMBER_OF_PLAYER==7:
		if idplayer=="4":
			if answer!='no':
				$Table/tomb_player5.show()
				hide_graphic_player(5)		
			pass
		
		if idplayer=="5":
			if answer!='no':
				$Table/tomb_player6.show()
				hide_graphic_player(6)
			pass
		
		if idplayer=="6":
			if answer!='no':
				$Table/tomb_player7.show()
				hide_graphic_player(7)
			pass	
		pass
	if global.NUMBER_OF_PLAYER==6:
		if idplayer=="4":
			if answer!='no':
				$Table/tomb_player5.show()
				hide_graphic_player(5)		
			pass
		
		if idplayer=="5":
			if answer!='no':
				$Table/tomb_player6.show()
				hide_graphic_player(6)
			pass

		pass
	if global.NUMBER_OF_PLAYER==5:
		if idplayer=="4":
			if answer!='no':
				$Table/tomb_player5.show()
				hide_graphic_player(5)		
			pass
		pass
	pass

func set_current_player_label(current_player):	
	if current_player==7:
		$Table/RollDice.label_login_name.text=$Table/label_name_p6.text
	if current_player==6:
		$Table/RollDice.label_login_name.text=$Table/label_name_p7.text
	if current_player==5:
		$Table/RollDice.label_login_name.text=$Table/label_name_p8.text
	if current_player==4:
		$Table/RollDice.label_login_name.text=$Table/label_name_p5.text
	if current_player==3:
		print("its " + str($Table/label_name_p4.text) + " turn")
		$Table/RollDice.label_login_name.text=$Table/label_name_p4.text
	if current_player==2:
		print("its " + str($Table/label_name_p3.text) + " turn")
		$Table/RollDice.label_login_name.text=$Table/label_name_p3.text
	if current_player==1:
		print("its " + str($Table/label_name_p2.text) + " turn")
		$Table/RollDice.label_login_name.text=$Table/label_name_p2.text
	if current_player==0:
		print("its " + str($Table/label_name_p1) + " turn")
		$Table/RollDice.label_login_name.text=$Table/label_name_p1.text
			
	pass

func show_role_to_everyone(player_id):
	pass

func CHANGE_DICE_FUNCTION(string):
	print("change dice signal catched")
	var dico= string#global.parsingForClient(string
	#if dico.has('dead'):
	
	print("HP")
	print(dico['hp'])
	print("ARROW")
	print(dico['arrow'])
	for dead_id in global.dead_player_array:
		print(global.dead_player_array[dead_id])
		if global.dead_player_array[dead_id]!='no':
			print(str(dead_id)+" is dead right...."+global.dead_player_array[str(dead_id)])
			set_dead(dead_id,global.dead_player_array[dead_id])	
			pass
		else:
			print(str(dead_id)+" n'est pas mort..."+global.dead_player_array[str(dead_id)])
		
		pass
	for HP_id in dico['hp']:
		if HP_id=='0':
			$Table/label_life_player1.text=str(global.life1)
		if HP_id=='1':
			$Table/label_life_player2.text=str(global.life2)
		if HP_id=='2':
			$Table/label_life_player3.text=str(global.life3)
		if HP_id=='3':
			$Table/label_life_player4.text=str(global.life4)
		
		if global.NUMBER_OF_PLAYER==8:
			if HP_id=='4':
				$Table/label_life_player5.text=str(global.life5)
			if HP_id=='5':
				$Table/label_life_player8.text=str(global.life6)
			if HP_id=='6':
				$Table/label_life_player7.text=str(global.life7)
			if HP_id=='7':
				$Table/label_life_player6.text=str(global.life8)
		elif global.NUMBER_OF_PLAYER==7:
			if HP_id=='4':
				$Table/label_life_player5.text=str(global.life5)
			if HP_id=='5':
				$Table/label_life_player8.text=str(global.life6)
			if HP_id=='6':
				$Table/label_life_player7.text=str(global.life7)
		elif global.NUMBER_OF_PLAYER==6:
			if HP_id=='4':
				$Table/label_life_player5.text=str(global.life5)
			if HP_id=='5':
				$Table/label_life_player8.text=str(global.life6)
		elif global.NUMBER_OF_PLAYER==5:
			if HP_id=='4':
				$Table/label_life_player5.text=str(global.life5)
		pass
	for HP_id in dico['arrow']:
		if HP_id=='0':
			$Table/label_arrow_player1.text= str(global.arrow1)
		if HP_id=='1':
			$Table/label_arrow_player2.text= str(global.arrow2)
		if HP_id=='2':
			$Table/label_arrow_player3.text= str(global.arrow3)
		if HP_id=='3':
			$Table/label_arrow_player4.text= str(global.arrow4)
		
		if global.NUMBER_OF_PLAYER==8:
			if HP_id=='4':
				$Table/label_arrow_player5.text= str(global.arrow5)
			if HP_id=='5':
				$Table/label_arrow_player8.text= str(global.arrow6)
			if HP_id=='6':
				$Table/label_arrow_player7.text= str(global.arrow7)
			if HP_id=='7':
				$Table/label_arrow_player6.text= str(global.arrow8)
		elif global.NUMBER_OF_PLAYER==7:
			if HP_id=='4':
				$Table/label_arrow_player5.text= str(global.arrow5)
			if HP_id=='5':
				$Table/label_arrow_player8.text= str(global.arrow6)
			if HP_id=='6':
				$Table/label_arrow_player7.text= str(global.arrow7)
		elif global.NUMBER_OF_PLAYER==6:
			if HP_id=='4':
				$Table/label_arrow_player5.text= str(global.arrow5)
			if HP_id=='5':
				$Table/label_arrow_player8.text= str(global.arrow6)
		elif global.NUMBER_OF_PLAYER==5:
			if HP_id=='4':
				$Table/label_arrow_player5.text= str(global.arrow5)
		pass
	
	var nb_arrows = 9
	$Table/RollDice.Information_Label.text= str(global.throwsleft)+" THROWS LEFT"
	nb_arrows -= (int(global.arrow1)+int(global.arrow2)+int(global.arrow3)+int(global.arrow4)+int(global.arrow5)+int(global.arrow6)+int(global.arrow7)+int(global.arrow8))
	$Table/label_arrows_left.text = str(nb_arrows)
	set_server_Dice_img($Table/RollDice.Dice1,global.dice_array_img_for_rolldice_after_timeout['dice']['0'])
	set_server_Dice_img($Table/RollDice.Dice2,global.dice_array_img_for_rolldice_after_timeout['dice']['1'])
	set_server_Dice_img($Table/RollDice.Dice3,global.dice_array_img_for_rolldice_after_timeout['dice']['2'])
	set_server_Dice_img($Table/RollDice.Dice4,global.dice_array_img_for_rolldice_after_timeout['dice']['3'])
	set_server_Dice_img($Table/RollDice.Dice5,global.dice_array_img_for_rolldice_after_timeout['dice']['4'])

	var select_button_img = load("res://imgs/select.png")
	$selectD1.set_button_icon(select_button_img) 
	$selectD2.set_button_icon(select_button_img) 
	$selectD3.set_button_icon(select_button_img) 
	$selectD4.set_button_icon(select_button_img) 
	$selectD5.set_button_icon(select_button_img) 
	
	set_current_player_label(global.current_player)
	pass

func ASSOCIATE_ROLE_FUNCTION(string):
	print("ASSOCIATE_ROLE signal catched")
	var dico=global.parsingForClient(string)
	print("ROLE")
	print(dico['role'])
	print("ALIAS")
	print(dico['alias'])
	print("CHARACTERS")
	print(dico['character'])
	print()
	for role_id in dico['role']:
		set_role_to_player(role_id,dico['role'][role_id])
		pass
	for char_id in dico['character']:
		print(char_id)
		set_character_to_player("id"+char_id,dico['character'][char_id])
		pass
	for char_id in dico['alias']:
		#print(char_id)
		if char_id=='0':
			$Table/label_name_p1.text=dico['alias'][char_id]
		if char_id=='1':
			$Table/label_name_p2.text=dico['alias'][char_id]
		if char_id=='2':
			$Table/label_name_p3.text=dico['alias'][char_id]
		if char_id=='3':
			$Table/label_name_p4.text=dico['alias'][char_id]
		
		
		if nbrPlayer==8:
			if char_id=='4':
				$Table/label_name_p5.text=dico['alias'][char_id]
			if char_id=='5':
				$Table/label_name_p8.text=dico['alias'][char_id]
			if char_id=='6':
				$Table/label_name_p7.text=dico['alias'][char_id]
			if char_id=='7':
				$Table/label_name_p6.text=dico['alias'][char_id]
		elif global.NUMBER_OF_PLAYER==7:
			if char_id=='4':
				$Table/label_name_p5.text=dico['alias'][char_id]
			if char_id=='5':
				$Table/label_name_p6.text=dico['alias'][char_id]
			if char_id=='6':
				$Table/label_name_p7.text=dico['alias'][char_id]
		elif global.NUMBER_OF_PLAYER==6:
			if char_id=='4':
				$Table/label_name_p5.text=dico['alias'][char_id]
			if char_id=='5':
				$Table/label_name_p6.text=dico['alias'][char_id]
		elif global.NUMBER_OF_PLAYER==5:
			if char_id=='4':
				$Table/label_name_p5.text=dico['alias'][char_id]
		pass 
	var player=global.current_player#dico["character"]["id"].to_int() 
	$Table/RollDice.label_login_name.text = global.dico_alias[global.current_player.to_str()]
	set_current_player_label(player)
	pass

func show_ROLLDICE_ENDTURNBUTTON_FUNCTION():
	print("show_ROLLDICE_ENDTURNBUTTON signal catched ")
	$Table/RollDice.RollDiceButton.visible=true
	$Table/RollDice.EndTurnButton.visible=true
	pass
	
func hide_ROLLDICE_ENDTURNBUTTON_FUNCTION():
	print("hide_ROLLDICE_ENDTURNBUTTON_FUNCTION signal catched ")
	$Table/RollDice.RollDiceButton.visible=false
	$Table/RollDice.EndTurnButton.visible=false
	pass
	
func DEAD_PLAYERS_FUNCTION():
	print("DEAD_PLAYERS_FUNCTION signal catched ")
	pass

func ENDGAME_FUNCTION():
	print("ENDGAME_FUNCTION signal catched ")
	pass

func send_effect_to_activate(Dice):
	if Dice == "1": # Damage 1
		print("Player chooses Who he gives 1 DMG")
		global.actual_dice_effect="1"
		print("Wait Player for answer...")
		#choose a player through the buttons 
		#send to server info (TODO)
		
	elif Dice == "2": #Damage 2
		print("Player chooses Who he gives 2 DMG")
		global.actual_dice_effect="2"
		print("Wait Player for answer...")
		#choose a player through the buttons 
		#send to server info (TODO)
	
	elif Dice == "B":# Heal
		print("Player chooses Who he Heals to the server")
		global.actual_dice_effect="B"
		print("Wait Player for answer...")
		#choose a player through the buttons 
		#send to server info (TODO)
	
	elif Dice == "G":# Gattling
		global.actual_dice_effect="G"
		print("GATTLING")
		
		#send to server info (TODO) 

	elif Dice == "A":# Arrow
		global.actual_dice_effect="A"
		print("Player takes an arrow")
		#send to server info (TODO)

	elif Dice == "D":# DYNAMITE
		global.actual_dice_effect="D"
		print("DYNAMITE") 
		#send to server info (TODO)

func hide_aim_buttons():
	$aimButton0.visible=false
	$aimButton1.visible=false
	$aimButton2.visible=false
	$aimButton3.visible=false
	$aimButton4.visible=false
	$aimButton5.visible=false
	$aimButton6.visible=false
	$aimButton7.visible=false


func show_activation_buttons():
	if global.dico_dice_effects[0]!="D" and global.dico_dice_effects[0]!="G" and global.dico_dice_effects[0]!="A":
		$selectD1.visible=true
	else:
		number_activated_effects+=1
		dict_activation_effect[0]="None"
	
	if global.dico_dice_effects[1]!="D" and global.dico_dice_effects[1]!="G" and global.dico_dice_effects[1]!="A":	
		$selectD2.visible=true
	else:
		number_activated_effects+=1
		dict_activation_effect[1]="None"
	
	if global.dico_dice_effects[2]!="D" and global.dico_dice_effects[2]!="G" and global.dico_dice_effects[2]!="A":
		$selectD3.visible=true
	else:
		number_activated_effects+=1
		dict_activation_effect[2]="None"
	
	if global.dico_dice_effects[3]!="D" and global.dico_dice_effects[3]!="G" and global.dico_dice_effects[3]!="A":
		$selectD4.visible=true
	else:
		number_activated_effects+=1
		dict_activation_effect[3]="None"
	
	if global.dico_dice_effects[4]!="D" and global.dico_dice_effects[4]!="G" and global.dico_dice_effects[4]!="A":
		$selectD5.visible=true
	else:
		number_activated_effects+=1
		dict_activation_effect[4]="None"
	pass


var dict_activation_effect
var Dice_used
var number_activated_effects
signal effects_finished

var string_to_send_to_server
func READING_DICE_EFFECT():
	print(global.current_player)
	#the roll dice button must be deactivated
	print("ACTIVATE_EFFECT_SIGNAL catched")
	dict_activation_effect={}
	Dice_used=0
	number_activated_effects=0
	
	$Table/RollDice.RollDiceButton.disabled=true
	#$Table/Rolldice.visible=false
	show_activation_buttons()
	
	var d1=global.dice_array_img_for_rolldice_after_timeout['dice']['0']
	var d2=global.dice_array_img_for_rolldice_after_timeout['dice']['1']
	var d3=global.dice_array_img_for_rolldice_after_timeout['dice']['2']
	var d4=global.dice_array_img_for_rolldice_after_timeout['dice']['3']
	var d5=global.dice_array_img_for_rolldice_after_timeout['dice']['4']
	
	if (d1!="1" and d1!="2" and d1!="b") and (d2!="1" and d2!="2" and d2!="b") and  (d3!="1" and d3!="2" and d3!="b") and (d4!="1" and d4!="2" and d4!="b") and (d5!="1" and d5!="2" and d5!="b"):
		pass
	else:
		yield(self,"effects_finished")
	
	#send Dice_effect to server 
	print(dict_activation_effect)
	string_to_send_to_server="Dice"
	for key in dict_activation_effect:
		string_to_send_to_server+=","+str(key) +":"+ str(dict_activation_effect[key])
		pass

	
	$"END TURN BUTTON".visible=true
	Activate0_on=0
	Activate1_on=0
	Activate2_on=0
	Activate3_on=0
	Activate4_on=0
#	$selectD1.text="ACTIVATE"
#	$selectD2.text="ACTIVATE"
#	$selectD3.text="ACTIVATE"
#	$selectD4.text="ACTIVATE"
#	$selectD5.text="ACTIVATE"
	pass
	

func _on_button_quit_pressed():
	print("Exiting game")
	var test = get_tree().change_scene("res://sources/menu/Menu.tscn")
	if(test != OK):
			print("error change scene : _on_button_quit_pressed ,  GamePlay.gd ")
	global.is_playing = 0
	pass # Replace with function body.


func _on_button_settings_pressed():
	#get_tree().paused = true
	print("Entering settings")
	var test = get_tree().change_scene("res://sources/menu/Settings.tscn")
	if(test != OK):
		print("error change scene : _on_button_settings_pressed ,  GamePlay.gd ")
	pass # Replace with function body.


func _on_button_agrandir_joueur_actuel_pressed():
	pass # Replace with function body.


func _on_Area2D_mouse_entered():
	print("mouse entered")
	pass # Replace with function body.
	
func _on_Area2D_mouse_exited():
	print("mouse exited")
	pass # Replace with function body.

func _on_popup_endgame_confirmed():
	get_tree().quit()
	pass # Replace with function body.


func _on_button_sheriff_pressed():
	if image1_big == 0 :
		if image_enlarged == 0:
			image1_big = 1
			print("image 1 agrandie : " + str(image1_big))
			$Table/SHERIF/sheriff_star.visible = false
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/SHERIF.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/SHERIF.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3
			
			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/SHERIF.position.x = 577.289
			$Table/SHERIF.position.y = 0.57
			$Table/SHERIF.scale.x = scale_base
			$Table/SHERIF.scale.y = scale_base
			image1_big = 0
			print("image 1 rétrécie : " + str(image1_big))

			$Table/SHERIF/sheriff_star.visible = true
			image_enlarged = 0
			
			#$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false

			
			$Table/sprite_zoomed_picture.texture = $Table/SHERIF.texture
			$Table/sprite_zoomed_picture.visible = false
			$Table/SHERIF.visible = true
			
			$Table/Role_player1.show()
			$Table/Role_player2.show()
			$Table/Role_player2.show()
			$Table/Role_player3.show()
			$Table/Role_player4.show()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.show()
				$Table/Role_player7.show()
				$Table/Role_player6.show()
				$Table/Role_player5.show()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.show()
				$Table/Role_player6.show()
				$Table/Role_player5.show()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.show()
				$Table/Role_player5.show()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.show()
			

		
	pass # Replace with function body.


func _on_button_p2_pressed():
	if image2_big == 0:
		if image_enlarged == 0:
			#$Table/Perso2.position.x = 0
			#$Table/Perso2.position.y = 0
			#$Table/Perso2.scale.x = scale_up
			#$Table/Perso2.scale.y = scale_up
			image2_big = 1
			print("image 2 agrandie : " + str(image2_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso2.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso2.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3
			
			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso2.position.x = image2x
			$Table/Perso2.position.y = image2y
			$Table/Perso2.scale.x = scale_base
			$Table/Perso2.scale.y = scale_base
			image2_big = 0
			print("image 2 rétrécie : " + str(image2_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p3_pressed():
	if image3_big == 0:
		if image_enlarged == 0:
			#$Table/Perso3.position.x = 0
			#$Table/Perso3.position.y = 0
			#$Table/Perso3.scale.x = scale_up
			#$Table/Perso3.scale.y = scale_up
			image3_big = 1
			print("image 3 agrandie : " + str(image3_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso3.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso3.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3
		
			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso3.position.x = image3x
			$Table/Perso3.position.y = image3y
			$Table/Perso3.scale.x = scale_base
			$Table/Perso3.scale.y = scale_base
			image3_big = 0
			print("image 3 rétrécie : " + str(image3_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p4_pressed():
	if image4_big == 0:
		if image_enlarged == 0:
			#$Table/Perso4.position.x = 0
			#$Table/Perso4.position.y = 0
			#$Table/Perso4.scale.x = scale_up
			#$Table/Perso4.scale.y = scale_up
			image4_big = 1
			print("image 4 agrandie : " + str(image4_big))
			image_enlarged = 1
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			$Table/sprite_zoomed_picture.texture = $Table/Perso4.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso4.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3

			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso4.position.x = image4x
			$Table/Perso4.position.y = image4y
			$Table/Perso4.scale.x = scale_base
			$Table/Perso4.scale.y = scale_base
			image4_big = 0
			print("image 4 rétrécie : " + str(image4_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p5_pressed():
	if image5_big == 0:
		if image_enlarged == 0:
			#$Table/Perso5.position.x = 0
			#$Table/Perso5.position.y = 0
			#$Table/Perso5.scale.x = scale_up
			#$Table/Perso5.scale.y = scale_up
			image5_big = 1
			print("image 5 agrandie : " + str(image5_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso5.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso5.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3

			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso5.position.x = image5x
			$Table/Perso5.position.y = image5y
			$Table/Perso5.scale.x = scale_base
			$Table/Perso5.scale.y = scale_base
			image5_big = 0
			print("image 5 rétrécie : " + str(image5_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p6_pressed():
	if image6_big == 0:
		if image_enlarged == 0:
			#$Table/Perso6.position.x = 0
			#$Table/Perso6.position.y = 0
			#$Table/Perso6.scale.x = scale_up
			#$Table/Perso6.scale.y = scale_up
			image6_big = 1
			print("image 6 agrandie : " + str(image6_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso6.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso6.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3

			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso6.position.x = image6x
			$Table/Perso6.position.y = image6y
			$Table/Perso6.scale.x = scale_base
			$Table/Perso6.scale.y = scale_base
			image6_big = 0
			print("image 6 rétrécie : " + str(image6_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p7_pressed():
	if image7_big == 0:
		if image_enlarged == 0:
			#$Table/Perso7.position.x = 0
			#$Table/Perso7.position.y = 0
			#$Table/Perso7.scale.x = scale_up
			#$Table/Perso7.scale.y = scale_up
			image7_big = 1
			print("image 7 agrandie : " + str(image7_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso7.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso7.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3

			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso7.position.x = image7x
			$Table/Perso7.position.y = image7y
			$Table/Perso7.scale.x = scale_base
			$Table/Perso7.scale.y = scale_base
			image7_big = 0
			print("image 7 rétrécie : " + str(image7_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_p8_pressed():
	if image8_big == 0:
		if image_enlarged == 0:
			#$Table/Perso8.position.x = 0
			#$Table/Perso8.position.y = 0
			#$Table/Perso8.scale.x = scale_up
			#$Table/Perso8.scale.y = scale_up
			image8_big = 1
			print("image 8 agrandie : " + str(image8_big))
			image_enlarged = 1
			
			$Table/RollDice.visible = false
			$sprite_background_darkened.visible = true
			
			$Table/sprite_zoomed_picture.texture = $Table/Perso8.texture
			$Table/sprite_zoomed_picture.visible = true
			$Table/Perso8.visible = false
			$Table/sprite_zoomed_picture.scale.x = 0.3
			$Table/sprite_zoomed_picture.scale.y = 0.3
			
			$Table/Role_player1.hide()
			$Table/Role_player2.hide()
			$Table/Role_player2.hide()
			$Table/Role_player3.hide()
			$Table/Role_player4.hide()
			if global.NUMBER_OF_PLAYER==8:
				$Table/Role_player8.hide()
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==7:
				$Table/Role_player7.hide()
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==6:
				$Table/Role_player6.hide()
				$Table/Role_player5.hide()
			if global.NUMBER_OF_PLAYER==5:
				$Table/Role_player5.hide()
	else:
		if image_enlarged == 1:
			$Table/Perso8.position.x = image8x
			$Table/Perso8.position.y = image8y
			$Table/Perso8.scale.x = scale_base
			$Table/Perso8.scale.y = scale_base
			image8_big = 0
			print("image 8 rétrécie : " + str(image8_big))
			image_enlarged = 0
			
			$Table/RollDice.visible = true
			$sprite_background_darkened.visible = false
	
	pass # Replace with function body.


func _on_button_unzooming_picture_pressed():
	if image1_big == 1:
		image1_big = 0
		image_enlarged = 0
		$Table/SHERIF.visible = true
		
	if image2_big == 1:
		image2_big = 0
		image_enlarged = 0
		$Table/Perso2.visible = true
	
	if image3_big == 1:
		image3_big = 0
		image_enlarged = 0
		$Table/Perso3.visible = true
	
	if image4_big == 1:
		image4_big = 0
		image_enlarged = 0
		$Table/Perso4.visible = true
		
	if image5_big == 1:
		image5_big = 0
		image_enlarged = 0
		$Table/Perso5.visible = true
	
	if image6_big == 1:
		image6_big = 0
		image_enlarged = 0
		$Table/Perso6.visible = true
		
	if image7_big == 1:
		image7_big = 0
		image_enlarged = 0
		$Table/Perso7.visible = true
	
	if image8_big == 1:
		image8_big = 0
		image_enlarged = 0
		$Table/Perso8.visible = true
		
	$sprite_background_darkened.visible = false
	$Table/sprite_zoomed_picture.visible = false
	
	$Table/RollDice.visible = true
	
	$Table/Role_player1.show()
	$Table/Role_player2.show()
	$Table/Role_player2.show()
	$Table/Role_player3.show()
	$Table/Role_player4.show()
	if global.NUMBER_OF_PLAYER==8:
		$Table/Role_player8.show()
		$Table/Role_player7.show()
		$Table/Role_player6.show()
		$Table/Role_player5.show()
	if global.NUMBER_OF_PLAYER==7:
		$Table/Role_player7.show()
		$Table/Role_player6.show()
		$Table/Role_player5.show()
	if global.NUMBER_OF_PLAYER==6:
		$Table/Role_player6.show()
		$Table/Role_player5.show()
	if global.NUMBER_OF_PLAYER==5:
		$Table/Role_player5.show()
	pass # Replace with function body.

func player_aiming(beginning,end,last_player_bool):
	print("test j")	
	for j in range(beginning,global.NUMBER_OF_PLAYER+1):#for(j=beginning,j<=nbplayer,j++)
		if get_node(str("Table/tomb_player",j)).visible==true:
			print(str("player ",j," is dead right..."))
			pass
		else:
			print(str("on montre aimbutton",j-1))
			get_node(str("aimButton",j-1)).show()
			break
		pass
	print("test k")
	
	var last
	if last_player_bool==false:
		last=global.NUMBER_OF_PLAYER
	else:
		last=global.NUMBER_OF_PLAYER-1
		
	for k in range(last,end,-1):# for(k= nbrplayer,k>end,k--)
		print(str("test k on player",k))
		if get_node(str("Table/tomb_player",k)).visible==true:
			print(str("player ",k," is dead right..."))
			pass
		else:
			print(str("on montre aimbutton",k-1))
			get_node(str("aimButton",k-1)).show()
			break
		pass	
	
	pass


func activate_direct_neighbour_of_current_player(current_player): # adapt nbr player
	#rename_aim_buttons("ATTACK")
	var i=current_player+1
	if i==1: #premier joueur 
		player_aiming(2,1,false)
		pass
	elif i==global.NUMBER_OF_PLAYER: #dernier player
		player_aiming(1,0,true)
	elif i!=1 and i!=global.NUMBER_OF_PLAYER: # les autres joeurs

		print("test j")	
		for j in range(i-1,0,-1):
			if get_node(str("Table/tomb_player",j)).is_visible():
				print(str("player ",j," is dead right..."))
				pass
			else:
				print(str("test j on player",j))
				print(str("on montre aimbutton",j-1))
				get_node(str("aimButton",j-1)).show()
				break
			pass
		
		print("test k")	
		var left_all_dead=false
		for k in range(i+1,global.NUMBER_OF_PLAYER+1):
			if get_node(str("Table/tomb_player",k)).is_visible():
				print(str("player ",k," is dead right..."))
				left_all_dead=true
				pass
			else:
				print(str("test k on player",k))
				print(str("on montre aimbutton",k-1))
				get_node(str("aimButton",k-1)).show()
				left_all_dead=false
				break
			pass
		
		if left_all_dead==true:
			for n in range(1,i):
				if get_node(str("Table/tomb_player",n)).is_visible():
					print(str("player ",n," is dead right..."))
					pass
				else:
					print(str("test n on player",n))
					print(str("on montre aimbutton",n-1))
					get_node(str("aimButton",n-1)).show()
					break
			pass
	
		pass
	pass
	

func activate_2_neighbour_of_current_player(current_player):# adapt nbr player
	#rename_aim_buttons("ATTACK")
	var i=current_player+1
	if i == 1:
		# coté gauche
		print("Premier joueur")
		var test_vide=true
		print("test gauche")
		for j in range(i+1,global.NUMBER_OF_PLAYER+1,1): # on test chaque joueur du coté gauche
			print(str("on verifie le joueur ",j))
			if get_node(str("Table/tomb_player",j)).is_visible():
				print(str("1627 player ",j," is dead right..."))
			else: # on test si un joueur est plus loin que celui ci
				print("on test si un joueur est plus loin que celui ci")
				for y in range(j+1,global.NUMBER_OF_PLAYER+1):
					if get_node(str("Table/tomb_player",y)).is_visible():
						print(str("1566 player ",y-1," is dead right..."))
					else:# il y a un jouer plus loin et vivant donc on le prend
						test_vide=false
						print(str("on prend le player ",y))
						get_node(str("aimButton",y-1)).show()
						break
				break
					
			pass
		
		
		
#		for j in range(i+2,global.NUMBER_OF_PLAYER+1,1):
#			if get_node(str("Table/tomb_player",j)).is_visible():
#				print(str("1627 player ",j," is dead right..."))
#				pass
#			else:
#				print(str("1566 test j on player",j))
#				print(str("on montre aimbutton",j-1))
#				test_vide=false
#				get_node(str("aimButton",j-1)).show()
#				break
#			pass
#
		if test_vide==true:
			print(str("le coté gauche est vide donc on prend le voisin direct du player ",i))
			if not get_node(str("Table/tomb_player",i)).is_visible():
				get_node(str("aimButton",i)).show()
			pass

		#coté droite
		test_vide=true
		print("test droit")
		for k in range(global.NUMBER_OF_PLAYER,1,-1):
			print(str("on verifie le joueur ",k))
			if get_node(str("Table/tomb_player",k)).is_visible():
				print(str("asdad player ",k," is dead right..."))
			else: # on test si un joueur est plus loin que celui ci
				for y in range(k-1,0,-1):
					if get_node(str("Table/tomb_player",y)).is_visible():
						print(str("1538 player ",y-1," is dead right..."))
					else:# il y a un jouer plus loin et vivant donc on le prend
						test_vide=false
						print(str("on prend le player ",y))
						get_node(str("aimButton",y-1)).show()
						break
				if test_vide==false:
					break
			pass
#		for k in range(global.NUMBER_OF_PLAYER-1,1,-1):
#			if get_node(str("Table/tomb_player",k)).is_visible():
#				print(str("player ",k," is dead right..."))
#				pass
#			else:
#				print(str("1538 test k on player",k))
#				print(str("on montre aimbutton",k-1))
#				test_vide=false
#				get_node(str("aimButton",k-1)).show()
#				break
#			pass
		if test_vide==true:
			print(str("le coté droit est vide donc on prend le voisin direct du player ",i))
			if not get_node(str("Table/tomb_player",global.NUMBER_OF_PLAYER)).is_visible():
				get_node(str("aimButton",global.NUMBER_OF_PLAYER-1)).show()
			pass
	if i ==global.NUMBER_OF_PLAYER:
		print("dernier joueur")
		# coté gauche
		print("coté gauche")
		var test_vide=true
		for j in range(1,global.NUMBER_OF_PLAYER,1): # on test chaque joueur du coté gauche
			print(str("on verifie le joueur ",j))
			if get_node(str("Table/tomb_player",j)).is_visible():
				print(str("1707 player ",j," is dead right..."))
			else: # on test si un joueur est plus loin que celui ci
				print("on test si un joueur est plus loin que celui ci")
				for y in range(j+1,global.NUMBER_OF_PLAYER+1):
					if get_node(str("Table/tomb_player",y)).is_visible():
						print(str("1722 player ",y-1," is dead right..."))
					else:# il y a un jouer plus loin et vivant donc on le prend
						test_vide=false
						print(str("on prend le player ",y))
						get_node(str("aimButton",y-1)).show()
						break
				break
			pass
		

		
#		for j in range(2,global.NUMBER_OF_PLAYER,1):
#			if get_node(str("Table/tomb_player",j)).is_visible():
#				print(str("1661 player ",j," is dead right..."))
#				pass
#			else:
#				print(str("1600 test j on player",j))
#				print(str("on montre aimbutton",j-1))
#				test_vide=false
#				get_node(str("aimButton",j-1)).show()
#				break
#			pass
		
#		if test_vide==true:
#			get_node(str("aimButton",i)).show()
#			pass
		#coté droite
		print("coté droit")		
		test_vide=true
		for k in range(i-1,0,-1): # on test chaque joueur du coté gauche
			print(str("on verifie le joueur ",k))
			if get_node(str("Table/tomb_player",k)).is_visible():
				print(str("1743 player ",k," is dead right..."))
			else: # on test si un joueur est plus loin que celui ci
				print("on test si un joueur est plus loin que celui ci")
				for y in range(k-1,0,-1):
					print(str("		test interne de ",y))
					if get_node(str("Table/tomb_player",y)).is_visible():
						print(str("1749 player ",y-1," is dead right..."))
					else:# il y a un jouer plus loin et vivant donc on le prend
						test_vide=false
						print(str("on prend le player ",y))
						get_node(str("aimButton",y-1)).show()
						break
				break
			pass
		
		
		
#		for k in range(i-2,0,-1):
#			if get_node(str("Table/tomb_player",k)).is_visible():
#				print(str("1678 player ",k," is dead right..."))
#				pass
#			else:
#				print(str("1617 test k on player",k))
#				print(str("on montre aimbutton",k-1))
#				test_vide=false
#				get_node(str("aimButton",k-1)).show()
#				break
#			pass

#		if test_vide==true:
#			get_node(str("aimButton",i-1)).show()
#			pass
		
		pass
	if i !=1 and i!=global.NUMBER_OF_PLAYER:
		var test_vide_gauche=true
		var test_vide_droite=true
		# coté gauche
		print(str("player ",i))
		print("coté gauche")
		if i+1 < global.NUMBER_OF_PLAYER:
			for j in range(i+1,global.NUMBER_OF_PLAYER,1): # on test chaque joueur du coté gauche
				print(str("on verifie le joueur ",j))
				if get_node(str("Table/tomb_player",j)).is_visible():
					print(str("1707 player ",j," is dead right..."))
				else: # on test si un joueur est plus loin que celui ci
					print("on test si un joueur est plus loin que celui ci")
					for y in range(j+1,global.NUMBER_OF_PLAYER+1):
						if get_node(str("Table/tomb_player",y)).is_visible():
							print(str("1722 player ",y-1," is dead right..."))
						else:# il y a un jouer plus loin et vivant donc on le prend
							test_vide_gauche=false
							print(str("on prend le player ",y))
							get_node(str("aimButton",y-1)).show()
							break
					break
				pass
		elif i+1 == global.NUMBER_OF_PLAYER:
			for k in range(1,global.NUMBER_OF_PLAYER-1,1): # on test chaque joueur du coté gauche
				print(str("on verifie le joueur ",k))
				if get_node(str("Table/tomb_player",k)).is_visible():
					print(str("1707 player ",k," is dead right..."))
				else: # on test si un joueur est plus loin que celui ci
					test_vide_gauche=false
					print(str("on prend le player ",k))
					get_node(str("aimButton",k-1)).show()
					break
		
		if test_vide_gauche==true:# si toute la partie gauche est vide
			# on test la partie droite
			
			var test_rest=true
			# on teste la partie gauche partant du dernier element
			for k in range(i+1,global.NUMBER_OF_PLAYER+1,-1):
				if get_node(str("Table/tomb_player",k)).is_visible():
					print(str("64 player ",k," is dead right..."))
					pass
				else:
					test_rest=false
					print(str("17 test k on player",k))
					print(str("on montre aimbutton",k-1))
					get_node(str("aimButton",k-1)).show()
					break
			
			#si tout le monde est vide, on choisis ce type
			if test_rest==true:		
				if not get_node(str("Table/tomb_player",i+1)).is_visible():
					print("tout le monde est mort sauf mon voisin gauche donc lui")
					get_node(str("aimButton",i)).show()
				pass
		
		print("coté droite")
		if i-1 > 1:
			for j in range(i-1,0,-1): # on test chaque joueur du coté gauche
					print(str("on verifie le joueur ",j))
					if get_node(str("Table/tomb_player",j)).is_visible():
						print(str("1707 player ",j," is dead right..."))
					else: # on test si un joueur est plus loin que celui ci
						print("on test si un joueur est plus loin que celui ci")
						for y in range(j-1,0,-1):
							if get_node(str("Table/tomb_player",y)).is_visible():
								print(str("1722 player ",y-1," is dead right..."))
							else:# il y a un jouer plus loin et vivant donc on le prend
								test_vide_droite=false
								print(str("on prend le player ",y))
								get_node(str("aimButton",y-1)).show()
								break
						break
					pass
		elif i-1== 1:
			for k in range(global.NUMBER_OF_PLAYER,1,-1):
				print(str("on verifie le joueur ",k))
				if get_node(str("Table/tomb_player",k)).is_visible():
					print(str("asdad player ",k," is dead right..."))
				else: # on test si un joueur est plus loin que celui ci
					test_vide_droite=false
					print(str("on prend le player ",k))
					get_node(str("aimButton",k-1)).show()
					break
				pass
				
		if test_vide_droite==true:# so toute la partie droite est vide
			var test_rest=true
			# on teste la partie gauche partant du dernier element
			for k in range(global.NUMBER_OF_PLAYER,i,-1):
				if get_node(str("Table/tomb_player",k)).is_visible():
					print(str("1764 player ",k," is dead right..."))
					pass
				else:
					test_rest=false
					print(str("1767 test k on player",k))
					print(str("on montre aimbutton",k-1))
					get_node(str("aimButton",k-1)).show()
					break
			
			#si tout le monde est vide, on choisis ce type
			if test_rest==true:		
				if not get_node(str("Table/tomb_player",i-1)).is_visible():
					print("tout le monde est mort sauf mon voisin droite donc lui")
					get_node(str("aimButton",i-2)).show()
			pass
		



#		if i+1 < global.NUMBER_OF_PLAYER:
#			for j in range(i+2,global.NUMBER_OF_PLAYER+1,1):
#				if get_node(str("Table/tomb_player",j)).is_visible():
#					print(str("1700 player ",j," is dead right..."))
#					if j==global.NUMBER_OF_PLAYER:
#						print("we are on the gauche limit")
#						break
#					pass
#				else:
#					print(str("1638 test j on player",j))
#					print(str("on montre aimbutton",j-1))
#					test_vide_gauche=false
#					get_node(str("aimButton",j-1)).show()
#					break
#				pass
#		elif i+1 == global.NUMBER_OF_PLAYER:
#			for j in range(1,global.NUMBER_OF_PLAYER,1):
#				if i!=j:
#					if get_node(str("Table/tomb_player",j)).is_visible():
#						print(str("1716 player ",j," is dead right..."))
#						pass
#					else:
#						print(str("1638 test j on player",j))
#						print(str("on montre aimbutton",j-1))
#						test_vide_gauche=false
#						get_node(str("aimButton",j-1)).show()
#						break
#					pass
#			pass
#		if test_vide_gauche==true:
#			if not get_node(str("Table/tomb_player",i+1)).is_visible():
#				print("tout le monde est mort sauf mon voisin gauche donc lui")
#				get_node(str("aimButton",i)).show()
#			pass
#		#coté droite
#		if i-1!=1:
#			for k in range(i-2,0,-1):
#				if get_node(str("Table/tomb_player",k)).is_visible():
#					print(str("1730 player ",k," is dead right..."))
#					pass
#				else:
#					print(str("1650 test k on player",k))
#					print(str("on montre aimbutton",k-1))
#					test_vide_droite=false
#					get_node(str("aimButton",k-1)).show()
#					break
#				pass
#		else:
#			for k in range(global.NUMBER_OF_PLAYER,i,-1):
#				if get_node(str("Table/tomb_player",k)).is_visible():
#					print(str("1752 player ",k," is dead right..."))
#					pass
#				else:
#					print(str("1755 test k on player",k))
#					print(str("on montre aimbutton",k-1))
#					test_vide_droite=false
#					get_node(str("aimButton",k-1)).show()
#					break
#			pass
#
#		if test_vide_droite==true:
#			var test_gauche=true
#			for k in range(global.NUMBER_OF_PLAYER,i,-1):
#				if get_node(str("Table/tomb_player",k)).is_visible():
#					print(str("1764 player ",k," is dead right..."))
#					pass
#				else:
#					test_gauche=false
#					print(str("1767 test k on player",k))
#					print(str("on montre aimbutton",k-1))
#					get_node(str("aimButton",k-1)).show()
#					break
#			if test_gauche==true:
#				if not get_node(str("Table/tomb_player",i-1)).is_visible():
#					print("tout le monde est mort sauf mon voisin droite donc lui")
#					get_node(str("aimButton",i-2)).show()
#
		pass
	


func setIcon(img):
	$aimButton0.set_button_icon(img)
	$aimButton1.set_button_icon(img)
	$aimButton2.set_button_icon(img)
	$aimButton3.set_button_icon(img)
	$aimButton4.set_button_icon(img)
	$aimButton5.set_button_icon(img)
	$aimButton6.set_button_icon(img)
	$aimButton7.set_button_icon(img)
	pass

func show_aim_buttons():
	setIcon(load("res://imgs/Biere.png"))
	if global.NUMBER_OF_PLAYER==8:
		if $Table/tomb_player1.is_visible():
			pass
		else:
			$aimButton0.visible=true
		if $Table/tomb_player2.is_visible():
			pass
		else:
			$aimButton1.visible=true
		if $Table/tomb_player3.is_visible():
			pass
		else:
			$aimButton2.visible=true
		if $Table/tomb_player4.is_visible():
			pass
		else:
			$aimButton3.visible=true
		if $Table/tomb_player5.is_visible():
			pass
		else:
			$aimButton4.visible=true
		if $Table/tomb_player6.is_visible():
			pass
		else:
			$aimButton5.visible=true
			
		if $Table/tomb_player7.is_visible():
			pass
		else:
			$aimButton6.visible=true
		if $Table/tomb_player8.is_visible():
			pass
		else:
			$aimButton7.visible=true
	
	if global.NUMBER_OF_PLAYER==7:
		if $Table/tomb_player1.is_visible():
			pass
		else:
			$aimButton0.visible=true
		if $Table/tomb_player2.is_visible():
			pass
		else:
			$aimButton1.visible=true
		if $Table/tomb_player3.is_visible():
			pass
		else:
			$aimButton2.visible=true
		if $Table/tomb_player4.is_visible():
			pass
		else:
			$aimButton3.visible=true
		if $Table/tomb_player5.is_visible():
			pass
		else:
			$aimButton4.visible=true
		if $Table/tomb_player6.is_visible():
			pass
		else:
			$aimButton5.visible=true
			
		if $Table/tomb_player7.is_visible():
			pass
		else:
			$aimButton6.visible=true

	if global.NUMBER_OF_PLAYER==6:
		if $Table/tomb_player1.is_visible():
			pass
		else:
			$aimButton0.visible=true
		if $Table/tomb_player2.is_visible():
			pass
		else:
			$aimButton1.visible=true
		if $Table/tomb_player3.is_visible():
			pass
		else:
			$aimButton2.visible=true
		if $Table/tomb_player4.is_visible():
			pass
		else:
			$aimButton3.visible=true
		if $Table/tomb_player5.is_visible():
			pass
		else:
			$aimButton4.visible=true
		if $Table/tomb_player6.is_visible():
			pass
		else:
			$aimButton5.visible=true
	
	if global.NUMBER_OF_PLAYER==5:
		if $Table/tomb_player1.is_visible():
			pass
		else:
			$aimButton0.visible=true
		if $Table/tomb_player2.is_visible():
			pass
		else:
			$aimButton1.visible=true
		if $Table/tomb_player3.is_visible():
			pass
		else:
			$aimButton2.visible=true
		if $Table/tomb_player4.is_visible():
			pass
		else:
			$aimButton3.visible=true
		if $Table/tomb_player5.is_visible():
			pass
		else:
			$aimButton4.visible=true
		
	if global.NUMBER_OF_PLAYER==4:
		if $Table/tomb_player1.is_visible():
			pass
		else:
			$aimButton0.visible=true
		if $Table/tomb_player2.is_visible():
			pass
		else:
			$aimButton1.visible=true
		if $Table/tomb_player3.is_visible():
			pass
		else:
			$aimButton2.visible=true
		if $Table/tomb_player4.is_visible():
			pass
		else:
			$aimButton3.visible=true


var Activate0_on=0
var Activate1_on=0
var Activate2_on=0
var Activate3_on=0
var Activate4_on=0

func discativation_effect_selection(nbr):
	if nbr==1:
		$selectD2.disabled=true
		$selectD3.disabled=true
		$selectD4.disabled=true
		$selectD5.disabled=true
	elif nbr==2:
		$selectD1.disabled=true
		$selectD3.disabled=true
		$selectD4.disabled=true
		$selectD5.disabled=true
	elif nbr==3:
		$selectD1.disabled=true
		$selectD2.disabled=true
		$selectD4.disabled=true
		$selectD5.disabled=true	
	elif nbr==4:
		$selectD1.disabled=true
		$selectD2.disabled=true
		$selectD3.disabled=true
		$selectD5.disabled=true
	elif nbr==5:
		$selectD1.disabled=true
		$selectD2.disabled=true
		$selectD3.disabled=true
		$selectD4.disabled=true
	pass
	
func reactivate_selection():
	$selectD1.disabled=false
	$selectD2.disabled=false
	$selectD3.disabled=false
	$selectD4.disabled=false
	$selectD5.disabled=false
	
	pass
	
	
func _on_selectD1_pressed():
	if Activate0_on==0:
		Activate0_on=1
#		$selectD1.text="UNCLICK"
		$selectD1.set_button_icon(load("res://imgs/cancel.png"))  # Load the icon for cancelling purposes
		global.actual_dice_effect=global.dico_dice_effects[0]
		Dice_used=0
		if global.actual_dice_effect=="1":
			activate_direct_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="2":
			activate_2_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="B":
			show_aim_buttons()
		discativation_effect_selection(1)
	else:
		Activate0_on=0
#		$selectD1.text="ACTIVATE"
		$selectD1.set_button_icon(load("res://imgs/select.png")) # I load my select icon
		hide_aim_buttons()
		reactivate_selection()
	pass # Replace with function body.


func _on_selectD2_pressed():
	if Activate1_on==0:
		Activate1_on=1
#		$selectD2.text="UNCLICK"
		$selectD2.set_button_icon(load("res://imgs/cancel.png"))
		global.actual_dice_effect=global.dico_dice_effects[1]
		Dice_used=1
		if global.actual_dice_effect=="1":
			activate_direct_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="2":
			activate_2_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="B":
			show_aim_buttons()
		discativation_effect_selection(2)
	else:
		Activate1_on=0
#		$selectD2.text="ACTIVATE"
		$selectD2.set_button_icon(load("res://imgs/select.png"))
		hide_aim_buttons()
		reactivate_selection()
	pass # Replace with function body.


func _on_selectD3_pressed():
	if Activate2_on==0:
		Activate2_on=1
#		$selectD3.text="UNCLICK" 
		$selectD3.set_button_icon(load("res://imgs/cancel.png"))
		global.actual_dice_effect=global.dico_dice_effects[2]
		Dice_used=2

		if global.actual_dice_effect=="1":
			activate_direct_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="2":
			activate_2_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="B":
			show_aim_buttons()
		discativation_effect_selection(3)
	else:
		Activate2_on=0
#		$selectD3.text="ACTIVATE"
		$selectD3.set_button_icon(load("res://imgs/select.png"))
		hide_aim_buttons()
		reactivate_selection()
	pass # Replace with function body.


func _on_selectD4_pressed():
	if Activate3_on==0:
		Activate3_on=1
#		$selectD4.text="UNCLICK"
		$selectD4.set_button_icon(load("res://imgs/cancel.png"))
		global.actual_dice_effect=global.dico_dice_effects[3]
		Dice_used=3
		if global.actual_dice_effect=="1":
			activate_direct_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="2":
			activate_2_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="B":
			show_aim_buttons()
		discativation_effect_selection(4)
	else:
		Activate3_on=0
#		$selectD4.text="ACTIVATE"
		$selectD4.set_button_icon(load("res://imgs/select.png"))
		hide_aim_buttons()
		reactivate_selection()
	pass # Replace with function body.


func _on_selectD5_pressed():
	if Activate4_on==0:
		Activate4_on=1
#		$selectD5.text="UNCLICK"
		$selectD5.set_button_icon(load("res://imgs/cancel.png"))
		global.actual_dice_effect=global.dico_dice_effects[4]
		Dice_used=4
		if global.actual_dice_effect=="1":
			activate_direct_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="2":
			activate_2_neighbour_of_current_player(global.current_player)
		elif global.actual_dice_effect=="B":
			show_aim_buttons()
		discativation_effect_selection(5)
	else:
		Activate4_on=0
#		$selectD5.text="ACTIVATE"
		$selectD5.set_button_icon(load("res://imgs/select.png"))
		hide_aim_buttons()
		reactivate_selection()
	pass # Replace with function body.


func _on_aimButton0_pressed():
	print("player1 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	dict_activation_effect[Dice_used]="0" #To give Client ID (TODO)
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton1_pressed():
	print("player2 selected")
	number_activated_effects+=1
	print(str(5-number_activated_effects) + " effects left")
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	dict_activation_effect[Dice_used]="1" #To give Client ID (TODO)
	hide_aim_buttons()
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	
	pass # Replace with function body.


func _on_aimButton2_pressed():
	print("player3 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	dict_activation_effect[Dice_used]="2" #To give Client ID (TODO)
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton3_pressed():
	print("player4 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	dict_activation_effect[Dice_used]="3" #To give Client ID (TODO)
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton4_pressed():
	print("player5 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	dict_activation_effect[Dice_used]="4" #To give Client ID (TODO)
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton5_pressed():
	print("player6 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	dict_activation_effect[Dice_used]="5" #To give Client ID (TODO)
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton6_pressed():

	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	if global.NUMBER_OF_PLAYER==8:
		print("player7 selected")
		dict_activation_effect[Dice_used]="6" #To give Client ID (TODO)
	elif global.NUMBER_OF_PLAYER==7:
		print("player6 selected")
		dict_activation_effect[Dice_used]="6"
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	pass # Replace with function body.


func _on_aimButton7_pressed():
	print("player8 selected")
	number_activated_effects+=1
	
	if Dice_used==0:
		$selectD1.visible=false
	if Dice_used==1:
		$selectD2.visible=false
	if Dice_used==2:
		$selectD3.visible=false
	if Dice_used==3:
		$selectD4.visible=false
	if Dice_used==4:
		$selectD5.visible=false
	
	if global.NUMBER_OF_PLAYER==8:
		print("player8 selected")
		dict_activation_effect[Dice_used]="7" #To give Client ID (TODO)
	elif global.NUMBER_OF_PLAYER==7:
		print("player7 selected")
		dict_activation_effect[Dice_used]="6"
	elif global.NUMBER_OF_PLAYER==6:
		print("player6 selected")
		dict_activation_effect[Dice_used]="5"
	hide_aim_buttons()
	print(str(5-number_activated_effects) + " effects left")
	if(number_activated_effects==5):
		emit_signal("effects_finished")
	reactivate_selection()
	
	pass # Replace with function body.


func _on_END_TURN_BUTTON_pressed():	
	
	print("We change player")
	print("now playing with player " + str(global.current_player))
	#global.current_player = (global.current_player + 1) % 8
	$Table/RollDice.init_everything()
	$Table/RollDice.EndTurnButton.disabled=true
	$"END TURN BUTTON".visible=false
	Activate0_on=0
	Activate1_on=0
	Activate2_on=0
	Activate3_on=0
	Activate4_on=0

	#the dice table will send the infos of the dices to the table.
	print("Dice,"+"0:"+dict_activation_effect[0]+","+"1:"+dict_activation_effect[1]+","+
	"2:"+dict_activation_effect[2]+","+
	"3:"+dict_activation_effect[3]+","+
	"4:"+dict_activation_effect[4]+",")
	
	print(string_to_send_to_server) 
	global.send(string_to_send_to_server)	
	$Table/RollDice.RollDiceButton.disabled=false
	global.first_turn=true
	global.show_rolldicebutton_and_ENDTURNButton_variable=false
	$Table/RollDice.hide_buttons()
	pass # Replace with function body.

func effect_confirmation():
	print("Est ce que tu veut activer ?")
	my_timer.connect("timeout",self,"player_didnt_choose", [], CONNECT_ONESHOT)
	my_timer.set_wait_time(5)
	my_timer.start() #to start
	$Table/VBoxContainer.show()	
	pass	

func player_didnt_choose():
	my_timer.stop()
	print("player_didnt_choose")
	global.send("_,effect:no")
	$Table/VBoxContainer.hide()
	pass

func _on_yesbutton_pressed():
	print("yes")
	my_timer.stop()
	global.send("_,effect:yes")
	$Table/VBoxContainer.hide()
	pass # Replace with function body.


func _on_nobutton_pressed():
	print("no")
	my_timer.stop()
	global.send("_,effect:no")
	$Table/VBoxContainer.hide()
	pass # Replace with function body.


func VictoryScreen():
	var dico= global.VictoryMsg
	print(dico)
	for role_id in dico['r']:
		set_role_to_player(role_id,dico['r'][role_id])
		pass	
	#ici on peut gérer les alias # pour les alias
	for alias_id in global.dico_alias:
		if dico['v'][alias_id]=='yes':
			print(global.dico_alias[alias_id] + ' a gagné')
			var player_label = Label.new()
			player_label.text=global.dico_alias[alias_id]
			player_label.set_size(Vector2(118,21))
			$Victory/VBoxContainer.add_child(player_label)
		else:
			print(global.dico_alias[alias_id] + ' a perdu')
		pass
	print("Let's show our victory screen")
	$Victory.show()
	
#	get_node("Victory/WinnerName").text = winner1 + \n + winner2 etc
	


func _on_button_leave_game_pressed():
	popup_leave.show()
	pass # Replace with function body.


func _on_popup_leave_game_confirmed():
	get_tree().change_scene("res://sources/menu/Menu.tscn")
	pass # Replace with function body.

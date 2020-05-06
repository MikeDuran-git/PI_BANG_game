extends Node



var ws_url = "ws://35.246.170.203:9091" 
var ws


var throwsleft
var login_name = ""

func parsingForClient(buf):
	
	var dico={}
	var splitArray
	var splitSubstringArray
	var splitTemporaryArray
	
	
	#Split découpe un string en sous-string en utilisant le symbole mit en 
	#paramètre comme separateur
	#Chaque sub-string est mit dans une case differente du tableau crée
	
	splitArray=buf.split(",",true,0)
	var size1=splitArray.size()
	
	if(size1>0):
		for i in range(0,size1):
			splitSubstringArray=splitArray[i].split(":",true,0)
			var size2=splitSubstringArray.size()
			
			if(size2==1):
				var dico2={}
				for j in range(i+1,size1):
					splitTemporaryArray=splitArray[j].split(":",true,0)
					var size3=splitTemporaryArray.size()
					
					if(size3==2):
						dico2[splitTemporaryArray[0].to_lower()]=splitTemporaryArray[1].to_lower()
					else:
						break

				dico[splitSubstringArray[0].to_lower()]=dico2
			
	return dico


 
var NUMBER_OF_PLAYER=8 # The number of player modified by Network 
# in settings

#var arrows_left = 9
# Le nombre de flèches sur le plateau
# Arrivé à 0, on enlève x PV aux joueurs
# en fontion du nb de flèches qu'ils ont


export var is_playing = 0
# if not playing : 0 // if playing : 1
export var current_player = 0

#l'effet du dés qui est activé
var actual_dice_effect=0
var dico_dice_effects={}
# le joueur actuel

var dico_alias
var life1 = 2
var life2 = 2
var life3 = 2
var life4 = 2
var life5 = 2
var life6 = 2
var life7 = 2
var life8 = 2

var arrow1 = 0
var arrow2 = 0
var arrow3 = 0
var arrow4 = 0
var arrow5 = 0
var arrow6 = 0
var arrow7 = 0
var arrow8 = 0

export var dice1_val = 0
var kappa = "kappa"
export var dice2_val = 0
export var dice3_val = 0
export var dice4_val = 0
export var dice5_val = 0

export var dice_val_general = 0

var game_is_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#launch music 
	startBang()

	
	
	# Connect base signals to get notified of connection open, close, and errors.
	#ws = get_tree().get_root().get_node("/root/global").ws
	ws = WebSocketClient.new()	

	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	ws.connect("data_received", self, "_on_data")
				
	var err = ws.connect_to_url(global.ws_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	
	var test = get_tree().change_scene("res://sources/menu/Menu.tscn")
	if(test != OK):
		print("error change scene : _ready,  global.gd ")
	
	pass # Replace with function body.
 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ws.poll()
	pass

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.


signal CHANGE_DICE
#signal ASSOCIATE_ROLE
signal show_ROLLDICE_ENDTURNBUTTON
signal hide_ROLLDICE_ENDTURNBUTTON
signal DEAD_PLAYERS
signal ENDGAME
signal CHAT_MESSAGE_RECEIVED(dico_chat)
signal UPDATE_CURRENT_NB_PLAYER
signal dynamites
signal EFFECT_RECEIVED
signal VICTORY_MSG

var first_turn=true
var dynamite_variable
var dead_player_array
var dice_array_img_for_rolldice_after_timeout
var msg_of_server
var ASSOSIATE_ROLE_variable=0
var CHANGE_DICE_variable=0
var show_rolldicebutton_and_ENDTURNButton_variable=false
var wait_for_player_answer_variable=false
var VictoryMsg
var dico_char
func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var string = ws.get_peer(1).get_packet().get_string_from_utf8()
	var string_split_comma=string.split(",")
	var dico = parsingForClient(string)	
	

	print("msg ressus par le server: "+string)
	print("")
	print("")
	print(string_split_comma)
	match string_split_comma[0]:
		"IN":
			print("ASSOCIATE_ROLE signal Launched")
			print("enter gameplay")
#			print(dico['hp'][HP_id])
			dico_char=dico['character']
			dico_alias = dico['alias']
			current_player=dico["current"]["id"].to_int() # pour savoir qui joue actuellement
			msg_of_server=string
			ASSOSIATE_ROLE_variable=1
			#current_player=dico["current"]["id"].to_int() # pour savoir qui joue actuellement
			var test = get_tree().change_scene("res://sources/game/Gameplay.tscn")
			if(test != OK):
				print("error change scene : _on_button_play_game_pressed ,  Menu.gd ")
		"~":
			#dico_alias = dico['alias']
			current_player=dico["current"]["id"].to_int() # pour savoir qui joue actuellement
			dead_player_array=dico['dead']
			var dicoThrows = dico['throws']
			throwsleft = dicoThrows['remain']
			var dicArrows = dico['arrow']
			var dicHp = dico['hp'] 
			life1 = dicHp['0']
			life2 = dicHp['1']
			life3 = dicHp['2']
			life4 = dicHp['3']
			arrow1 = dicArrows['0']
			arrow2 = dicArrows['1']
			arrow3 = dicArrows['2']
			arrow4 = dicArrows['3']
			if global.NUMBER_OF_PLAYER==8:
				life5 = dicHp['4']
				life6 = dicHp['5']
				life7 = dicHp['6']
				life8 = dicHp['7']
				arrow1 = dicArrows['4']
				arrow2 = dicArrows['5']
				arrow3 = dicArrows['6']
				arrow4 = dicArrows['7']
			elif global.NUMBER_OF_PLAYER==7:
				life5 = dicHp['4']
				life6 = dicHp['5']
				life7 = dicHp['6']
				arrow5 = dicArrows['4']
				arrow6 = dicArrows['5']
				arrow7 = dicArrows['6']
			elif global.NUMBER_OF_PLAYER==6:
				life5 = dicHp['4']
				life6 = dicHp['5']
				arrow5 = dicArrows['4']
				arrow6 = dicArrows['5']
			elif global.NUMBER_OF_PLAYER==5:
					life5 = dicHp['4']
					arrow5 = dicArrows['4']
			
			print("MY TURN")
			#print(string_split_comma)
			
			print("actual_player= " + str(current_player))
			show_rolldicebutton_and_ENDTURNButton_variable=true
		
			#we put the dices values in an array. so that rolldice after the timeout will print them
			dice_array_img_for_rolldice_after_timeout=dico
			
			var count_dyna=0
			dynamite_variable=0
			if first_turn==false:
				print("the first throw is over")
				for i in dice_array_img_for_rolldice_after_timeout['dice']:
					print(dice_array_img_for_rolldice_after_timeout['dice'][i])
					if dice_array_img_for_rolldice_after_timeout['dice'][i] == 'd':
						count_dyna+=1
				if count_dyna >=3:
					dynamite_variable=1
			else:
				print("first throw")
							
			#print(dice_array_img_for_rolldice_after_timeout)
			
			
			if string_split_comma[1]=="Dice" :
				print("envoi signal de des ")
				emit_signal("CHANGE_DICE")
		"!":
			
			
			#dico_alias = dico['alias']
			dead_player_array=dico['dead']
			current_player=dico["current"]["id"].to_int() # pour savoir qui joue actuellement
			var dicoThrows = dico['throws']
			throwsleft = dicoThrows['remain']
			var dicArrows = dico['arrow']
			var dicHp = dico['hp'] 
			life1 = dicHp['0']
			life2 = dicHp['1']
			life3 = dicHp['2']
			life4 = dicHp['3']
			arrow1 = dicArrows['0']
			arrow2 = dicArrows['1']
			arrow3 = dicArrows['2']
			arrow4 = dicArrows['3']
			if global.NUMBER_OF_PLAYER==8:
				life5 = dicHp['4']
				life6 = dicHp['5']
				life7 = dicHp['6']
				life8 = dicHp['7']
				arrow1 = dicArrows['4']
				arrow2 = dicArrows['5']
				arrow3 = dicArrows['6']
				arrow4 = dicArrows['7']
			elif global.NUMBER_OF_PLAYER==7:
				life5 = dicHp['4']
				life6 = dicHp['5']
				life7 = dicHp['6']
				arrow5 = dicArrows['4']
				arrow6 = dicArrows['5']
				arrow7 = dicArrows['6']
			elif global.NUMBER_OF_PLAYER==6:
				life5 = dicHp['4']
				life6 = dicHp['5']
				arrow5 = dicArrows['4']
				arrow6 = dicArrows['5']
			elif global.NUMBER_OF_PLAYER==5:
					life5 = dicHp['4']
					arrow5 = dicArrows['4']
			
			
			print("NOT MY TURN")
			#print(string_split_comma)
			current_player=dico["current"]["id"].to_int() # pour savoir qui joue actuellement
			show_rolldicebutton_and_ENDTURNButton_variable=false
			
			#we put the dices values in an array. so that rolldice after the timeout will print them
			dice_array_img_for_rolldice_after_timeout=dico
			print(dice_array_img_for_rolldice_after_timeout)
			
			if string_split_comma[1]=="Dice":
				print("envoi signal de des ")
				emit_signal("CHANGE_DICE")
		"@":
			#change nbr of player
			#msg_of_server=string
			global.NUMBER_OF_PLAYER = (string.split(":")[1]).to_int()
			emit_signal("UPDATE_CURRENT_NB_PLAYER")
			
		"dead":
			#msg_of_server=string
			print("DEAD_PLAYERS signal Launched")
			emit_signal("DEAD_PLAYERS")
			
		"end":
			#msg_of_server=string
			print("ENDGAME signal Launched")
			emit_signal("ENDGAME")
		
		"chat":
			#msg_of_server=string
			print("CHAT_MESSAGE_RECEIVED signal Launched")
			var dico_chat = dico["chat"]
			emit_signal("CHAT_MESSAGE_RECEIVED", dico_chat);
			
		"_":
			print("Effect received")
			print(dico)
			var dic = dico["_"]["effect"]
			print(dic)
			wait_for_player_answer_variable=true
			emit_signal("EFFECT_RECEIVED")
		"Victory": 
			print("le message de victoire est apparu")
			VictoryMsg=dico
			emit_signal("VICTORY_MSG")
			

func send(string):
	 global.ws.get_peer(1).put_packet(string.to_utf8())


func startBang():
	var bangSound = AudioStreamPlayer.new()
	self.add_child(bangSound)
	bangSound.stream = load("res://music/pan.wav")
	bangSound.volume_db=-30
	bangSound.play()


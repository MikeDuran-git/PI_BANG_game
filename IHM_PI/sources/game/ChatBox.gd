extends Node2D

onready var chatlog = $VBoxContainer/RichTextLabel
onready var inputLabel = $VBoxContainer/HBoxContainer/Label
onready var inputField = $VBoxContainer/HBoxContainer/LineEdit

signal CHAT_MESSAGE_RECEIVED(dico_chat)


var player_index=0

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus() # no matter the UI the focus stays on input 
			#field
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()

#to change the player when a text was written  (changed when the network is on)
func _ready():
	# when the inputField is changed
	inputField.connect("text_entered",self,"text_entered")
	global.connect("CHAT_MESSAGE_RECEIVED",self,"receive_network_msg",[],CONNECT_PERSIST)
	$VBoxContainer/HBoxContainer/Label.text = global.login_name + ' : '
	pass # Replace with function body.

# function that adds the written text to the chatbox
func add_msg(dico_chat):
	
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += '[color='+ '#000000' +']'
	chatlog.bbcode_text += '[' + dico_chat['alias'] + ']: '
	chatlog.bbcode_text += '[/color]'
	chatlog.bbcode_text += '[color='+ '#ffffff' +']'
	chatlog.bbcode_text += dico_chat['text']
	chatlog.bbcode_text += '[/color]'

# function that is called when a text is entered in the inputField
func text_entered(text):
	if text != "":
		global.send("chat,text:" + text)
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += '[color='+ '#000000' +']'  
	chatlog.bbcode_text += '[' + global.login_name + ']: '
	chatlog.bbcode_text += '[/color]'
	chatlog.bbcode_text += '[color='+ '#ffffff' +']' 
	chatlog.bbcode_text += text
	chatlog.bbcode_text += '[/color]'
	inputField.text = ''

func receive_network_msg(dico_chat):
	var message = dico_chat['text']
	if message != "":
		add_msg(dico_chat)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

################################# SHOW CHAT OR HIDE IT #################################

var hideAndshow = 0

func _on_Button_pressed():
	
	if(hideAndshow == 0):
		hideAndshow = 1
		$"VBoxContainer".visible = true
		$"VBoxContainer/RichTextLabel".visible = true
		$"VBoxContainer/HBoxContainer".visible = true
		$"VBoxContainer/HBoxContainer/Label".visible = true
		$"VBoxContainer/HBoxContainer/LineEdit".visible = true
	elif(hideAndshow == 1):
		hideAndshow = 0
		$"VBoxContainer".visible = false
		$"VBoxContainer/RichTextLabel".visible = false
		$"VBoxContainer/HBoxContainer".visible = false
		$"VBoxContainer/HBoxContainer/Label".visible = false
		$"VBoxContainer/HBoxContainer/LineEdit".visible = false
	





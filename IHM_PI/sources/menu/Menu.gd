extends Node2D

onready var http_login : HTTPRequest = $button_play_game/HTTPRequest2
onready var http_login2 : HTTPRequest = $button_play_game/HTTPRequest3
onready var mail_login : LineEdit = $lineedit_login
onready var password_login : LineEdit = $lineedit_pwd

onready var http_register : HTTPRequest = $button_validate_signup/HTTPRequest
onready var mail_register : LineEdit = $signup_email
onready var pseudo_register : LineEdit = $signup_login
onready var password_register : LineEdit = $signup_pwd
onready var password_confirm : LineEdit = $signup_pwd2
onready var notification : Label = $error_signup_label

func _ready():
	global.connect("UPDATE_CURRENT_NB_PLAYER",self,"update_nb_player")
	pass

# boutton settings
func _on_button_settings_pressed():
	if $lineedit_login.text != "": # it keeps the login visible on the lineedit
		global.login_name = $lineedit_login.text
	print(global.login_name)
	var test = get_tree().change_scene("res://sources/menu/Settings.tscn") # go to settings
	if(test != OK):
		print("error change scene : _on_button_settings_pressed ,  Menu.gd ")
	
func hide_register():
	$error_signup_label.hide()
	$logo.visible = true
	$button_to_signup.visible = true
	$button_play_game.visible = true
	$lineedit_login.visible = true
	$lineedit_pwd.visible = true
	# show the sign up rich label
	$signup.visible = true
	
	$signup_login.visible = false
	$signup_pwd.visible = false
	$signup_pwd2.visible = false
	$signup_email.visible = false
	$button_validate_signup.visible = false
	$button_goback_login.visible = false
	
	$signup_login.clear()
	$signup_pwd.clear()
	$signup_pwd2.clear()
	$signup_email.clear()
	

#switch sur le menu de création de compte
func _on_button_to_signup_pressed():
	#Animation is activated
	var myAnimation = get_node("SignupAnimation")
	myAnimation.play("SignupAnimation")
	# hide the sign up rich label
	$signup.visible = false
	$error_signup_label.hide()
	$logo.visible = false
	$button_to_signup.visible = false
	$button_play_game.visible = false
	$lineedit_login.visible = false
	$lineedit_pwd.visible = false
	$signup_login.visible = true
	$signup_pwd.visible = true
	$signup_pwd2.visible = true
	$signup_email.visible = true
	$button_validate_signup.visible = true
	$button_goback_login.visible = true
	$PopupWindowValidation.visible = false
	
	pass # Replace with function body.

# switch sur le menu de connection
func _on_button_goback_login_pressed():
	#hide registers buttons
	hide_register()
	pass # Replace with function body.

func http_verif( response_code: int, body: PoolByteArray, var type ):
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
		notification.show()
	else:
		if(type==1):	
			return
		if(type==2):
			hide_register()
			#then pop the window
			$PopupWindowValidation.popup()
		if(type==3):
			$signup.hide()
			notification.add_color_override("font_color", Color(1,1,1))
			var response_body2 = JSON.parse(body.get_string_from_ascii()).result as Dictionary
			Firebase.profile=response_body2.fields
			var nickname = str(Firebase.profile.pseudo.stringValue)
			notification.text = "Hello " + nickname + ", glad to see you !"
			notification.show()
			global.login_name = nickname
			global.send("@,Alias:"+global.login_name)
			$gameLaunchStateWindow.show()
			$button_play_game.hide()			
	pass

# lauch when a http request is completed for login and check returns	
func _on_HTTPRequest2_request_completed(_result : int, response_code: int, _headers: PoolStringArray, body: PoolByteArray) -> void:
	http_verif(response_code,body,1)
	pass # Replace with function body.
	
# lauch when a http request is completed for registration and check returns	
func _on_HTTPRequest_request_completed(_result: int, response_code: int, _headers: PoolStringArray, body: PoolByteArray) -> void:
	http_verif(response_code,body,2)

func _on_HTTPRequest3_request_completed(result, response_code, _headers, body):
	http_verif(response_code,body,3)
	pass # Replace with function body.
	
func _on_button_validate_signup_pressed():
	$error_signup_label.hide()
	#signup()
	if mail_register.text.empty():
		notification.text = "mail is empty"
		notification.show()
		return
	if password_register.text.empty():
		notification.text = "password is empty"
		notification.show()
		return
	if pseudo_register.text.empty():
		notification.text = "pseudo is empty"
		notification.show()
		return
	if password_register.text != password_confirm.text:
		notification.text = "Password are not the same"
		notification.show()
		return
	Firebase.register(mail_register.text, password_register.text, pseudo_register.text, http_register)
	pass # Replace with function body.

func _on_button_play_game_pressed():
	#global.play("res://music/pan.wav")
	if mail_login.text.empty() or password_login.text.empty():
		notification.text = "Please, enter your username and password"
		notification.show()
		return
	Firebase.login(mail_login.text, password_login.text, http_login, http_login2)
	
	
	
#These two functions exist only to stop the Debugger to call error because they
# were not found
func _on_lineedit_login_text_changed(_new_text):
	pass # Replace with function body.

func _on_lineedit_pwd_text_changed(_new_text):
	pass # Replace with function body.

func _on_Button_pressed():
	var test = get_tree().change_scene("res://sources/game/Player.tscn")
	if(test != OK):
		print("error change scene : _on_button_pressed ,  Menu.gd ")
	pass # Replace with function body.

func update_nb_player():
	$gameLaunchStateWindow/currentNbPlayerLabel.text = "Nombre de joueurs actuel : " + str(global.NUMBER_OF_PLAYER)




func _on_button_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

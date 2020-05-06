extends Node2D


var volume 


func _ready():
	pass


# Go back to menu
func _on_button_back_pressed():
	# The parameters changed on the settings probably don't apply since it reloads the scene again
	get_tree().change_scene("res://sources/menu/Menu.tscn")


# Useless function 
#func _on_Button_pressed():
#	$music.play()
	pass # Replace with function body.



# Change all of this with the new setup, this is bad
#func _on_HSlider_value_changed(value):
#	volume = $HSlider.value
#	$music.volume_db = volume
#	global.GLOBAL_GAME_VOLUME=$music.volume_db
#	print("volume = " + str($music.volume_db))
#	print("volume_db = " + str($music.volume_db))
#	$label_Volume.text="Volume " + str(floor($music.volume_db)) + ":"
	pass # Replace with function body


# Brief : set labels/items at the specified label depending on id 
# Arg : 1 : French   ;    0 : English
func _on_Languagedropdownmenu_item_selected(id):
	# French
	if(id == 1):
		$label_Volume.text = "Volume de la musique"
		$LabelDisplayMode.text ="Mode d'affichage"
		$LanguageLabel.text = "Langue"
				# ******* DISPLAY MODE ******** #
		#item 0
		get_node("FullScreenDropDownMenu").set_item_text(0,"Mode fenêtre")
		#item 1
		get_node("FullScreenDropDownMenu").set_item_text(1,"Plein écran")
				# ******* Language ******** #
		#item 0
		get_node("Languagedropdownmenu").set_item_text(0,"Anglais")
		#item 1
		get_node("Languagedropdownmenu").set_item_text(1,"Français")
		
		# Resolution
		get_node("Resolution").text = "Résolution"
		
		
	# English	
	else:
		$label_Volume.text = "Music Volume"
		$LabelDisplayMode.text ="Display Mode"
		$LanguageLabel.text = "Language"
				# ******* DISPLAY MODE ******** #
		#item 0
		get_node("FullScreenDropDownMenu").set_item_text(0,"Windowed")
		#item 1
		get_node("FullScreenDropDownMenu").set_item_text(1,"Fullscreen")
				# ******* Language ******** #
		#item 0
		get_node("Languagedropdownmenu").set_item_text(0,"French")
		#item 1
		get_node("Languagedropdownmenu").set_item_text(1,"English")
		
		
		# Resolution
		get_node("Resolution").text = "Resolution"
		




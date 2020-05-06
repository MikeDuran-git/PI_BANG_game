extends OptionButton

func _ready():
	self.add_item("English", 0) 
	self.add_item("French", 1) 



func _on_DDMenuLanguage_item_selected(id):
	# French 
	if(id == 1):
		$"../MusicVolume".text = "Volume de la musique"
		$"../DisplayMode".text ="Mode d'affichage"
		$"../Language".text = "Langue"
				# ******* DISPLAY MODE ******** #
		#item 0
		
		
		
		
		get_node("../DDMenuDisplayMode").set_item_text(0,"Mode fenêtre")
		#item 1
		get_node("../DDMenuDisplayMode").set_item_text(1,"Plein écran")
				# ******* Language ******** #
		#item 0
		get_node(".").set_item_text(0,"Anglais") # or just set_item_text (current node)
		#item 1
		get_node(".").set_item_text(1,"Français")
		
		# Resolution
		get_node("../DDMenuResolution").text = "Résolution"
		
		
	# English	
	else:
		$"../MusicVolume".text = "Music Volume"
		$"../DisplayMode".text ="Display Mode"
		$"../Language".text = "Language"
				# ******* DISPLAY MODE ******** #
		#item 0
		get_node("../DDMenuDisplayMode").set_item_text(0,"Windowed")
		#item 1
		get_node("../DDMenuDisplayMode").set_item_text(1,"Fullscreen")
				# ******* Language ******** #
		#item 0
		get_node(".").set_item_text(0,"French")
		#item 1
		get_node(".").set_item_text(1,"English")
		
		
		# Resolution
		get_node("../DDMenuResolution").text = "Resolution"

extends OptionButton


func _ready():
	# Problem : the scenes are separated, can't keep the selected item since the scenes
	# are initialiazed every time	

	text = get_item_text(get_selected_id()) # get the current item
	self.add_item("Windowed", 0) 
	self.add_item("Fullscreen", 1) 


func _on_DDMenuDisplayMode_item_selected(id):
	if(id == 0):
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

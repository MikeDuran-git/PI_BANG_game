extends OptionButton



# Main function
func _ready():
	self.add_item("1920 x 1080", 0) 
	self.add_item("1600 x 900", 1)
	self.add_item("1366 x 900", 2)
	self.add_item("1366 x 768", 3)
	self.add_item("1360 x 768", 4)
	self.add_item("1280 x 720", 5)
	



# Screen resolutions
func _on_OptionButton_item_selected(id):
	if(id == 0):
		OS.set_window_size(Vector2(1920,1080))
	elif(id == 1):
		OS.set_window_size(Vector2(1600,900))
	elif(id == 2): 
		OS.set_window_size(Vector2(1366,900))
	elif(id == 3): 
		OS.set_window_size(Vector2(1366,768))
	elif(id == 4): 
		OS.set_window_size(Vector2(1360,768))
	elif(id == 5): 
		OS.set_window_size(Vector2(1280,720))
	

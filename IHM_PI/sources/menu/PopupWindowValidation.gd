extends Popup


#var myTheme = Theme.new()
var my_style = StyleBoxFlat.new()
# Set my font color
#myTheme.set_color("font_color", "Label", Color(1.0, 1.0, 1.0))


#var l = Label.new()
#l.set_theme(t)


func _ready():
	my_style.set_bg_color(Color(0.57,0.47,0.44,0.17))
	set("custom_styles/normal", my_style)
	var myTheme = Theme.new()
	myTheme.set_color("font_color", "Label", Color(1.0, 1.0, 1.0))
	
	
	
	



	


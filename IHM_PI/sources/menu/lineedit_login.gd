extends LineEdit



var my_style = StyleBoxFlat.new()



# The colour when mouse cursor is not focused on it
func _ready():
	my_style.set_bg_color(Color(0.57,0.47,0.44,0.17))

	# Set the "normal" style to be your newly created style.
	set("custom_styles/normal", my_style)
	#border width
	my_style.set_border_width_all(1)
	my_style.set_border_color(Color(0.07,0.05,0.05,1))
	# corner radius
	my_style.set_corner_radius_all(3)
	# Original text color
	set("custom_colors/font_color",Color(0.81,0.64,0.64,1))
	
	
	
# when mouse is on the lineedit
func _on_lineedit_login_mouse_entered():

	my_style.set_bg_color(Color(0.57,0.47,0.44,0.45))
	set("custom_styles/normal", my_style)
	# font color gets darker
	set("custom_colors/font_color",Color(0.9,0.78,0.84,1))
	
	
# When exit, keeps the same color
func _on_lineedit_login_mouse_exited():
	
	my_style.set_bg_color(Color(0.57,0.47,0.44,0.17))
	# Set the "normal" style to be your newly created style.
	set("custom_styles/normal", my_style)
	# Get back to original text color
	set("custom_colors/font_color",Color(0.81,0.64,0.64,1))
	
	

# When you click on the lineeddit
func _on_lineedit_login_focus_entered():
	# when clicked, border gets larger
	my_style.set_border_width_all(3)
	# background color gets red
	
	# tant que le focus de la souris est sur le texte 
	my_style.set_bg_color(Color(0.85,0.11,0.23,0.43))
	set("custom_styles/normal", my_style)
#	

# when you exit the focus of the lineedit
func _on_lineedit_login_focus_exited():
	#go back to normal border
	my_style.set_border_width_all(1)
	#go back to normal background style
	my_style.set_bg_color(Color(0.57,0.47,0.44,0.17))
	set("custom_styles/normal", my_style)
	

	
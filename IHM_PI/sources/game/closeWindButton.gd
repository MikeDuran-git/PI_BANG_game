extends Button




func _on_closeWindButton_pressed():
	get_node("../Panel").visible = false
	get_node("../Line").visible = false
	get_node("../Paramaters").visible = false
	visible = false # Current node
	get_node("../MusicVolume").visible = false
	get_node("../HSlider").visible = false
	get_node("../DisplayMode").visible = false
	get_node("../DDMenuDisplayMode").visible = false
	get_node("../Language").visible = false
	get_node("../DDMenuLanguage").visible = false
	get_node("../Resolution").visible = false
	get_node("../DDMenuResolution").visible = false













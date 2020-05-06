extends Button

func _ready():
	pass



func _on_GameplaySettingButton_pressed():
	get_node("../Panel").visible = true
	get_node("../Line").visible = true
	get_node("../Paramaters").visible = true
	get_node("../closeWindButton").visible = true
	get_node("../MusicVolume").visible = true
	get_node("../HSlider").visible = true
	get_node("../DisplayMode").visible = true
	get_node("../DDMenuDisplayMode").visible = true
	get_node("../Language").visible = true
	get_node("../DDMenuLanguage").visible = true
	get_node("../Resolution").visible = true
	get_node("../DDMenuResolution").visible = true
	

	

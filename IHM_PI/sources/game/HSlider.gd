extends HSlider





func _on_HSlider_value_changed(value):
	var Music = get_node("GameplayMusic")
	
	var valueVolumeSlider = 100 - value
	var myVolume = 24 - (valueVolumeSlider * 0.5)
	Music.volume_db = myVolume 

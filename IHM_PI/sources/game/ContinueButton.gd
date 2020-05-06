extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal QUIT_GAME_SIGNAL

func _on_ContinueButton_pressed():
	print("WE EXIT THE GAME")
	emit_signal("QUIT_GAME_SIGNAL")
	print("QUIT_GAME_SIGNAL launched")
	pass # Replace with function body.

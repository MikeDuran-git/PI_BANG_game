extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SignUpButton_pressed():
	var test = get_tree().change_scene("res://sources/UI/signup.tscn")
	if(test != OK):
		print("error change scene :  _on_SignUpButton_pressed, loginScene.gd ")

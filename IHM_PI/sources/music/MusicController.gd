extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _player = get_node("AudioStreamPlayer")
#onready var pan = get_node("sound_pan")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pan():
	$sound_pan.playing = true

func play(track_url: String):
	var track = load(track_url)
	_player.stream = track
	_player.playing = true
	
func stop():
	_player.playing = false

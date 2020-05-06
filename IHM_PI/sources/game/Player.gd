extends Node2D


var alive = 1 # is the player alive or dead
var role = 1 # is the player a sheriff, an adjoint, ...
var character = 1 # which character is the player playing ?
var life = 1 # life of player, number depends of his character
var dynamite = 0 # the player starts its round with 0 dynamite
var arrow = 0
var labellife_text = "Life = avbl"
var labelarrow_text = "Arrow = aval"

var cpt


# Called when the node enters the scene tree for the first time.
func _ready():
	cpt = 0
	life = 2
	alive = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cpt += 1
	
	#print(str(global.dice1_val))
	#global.dice1_val += 1
	
	if cpt % 60 == 0:
		print(str(global.dice1_val))
		labellife_text = "Life = " + str(life)
		labelarrow_text = "Arrow = " + str(arrow)
		$player/labellife.text = labellife_text
		$player/labelarrow.text = labelarrow_text
		
	if cpt == 360:
		print("dice1 : " + str(global.dice1_val))
		print("dice2 : " + str(global.dice2_val))
		print("dice3 : " + str(global.dice3_val))
		print("dice4 : " + str(global.dice4_val))
		print("dice5 : " + str(global.dice5_val))
			
		if global.dice1_val == 5:
			arrow +=1
		if global.dice2_val == 5:
			arrow +=1
		if global.dice3_val == 5:
			arrow +=1
		if global.dice4_val == 5:
			arrow +=1
		if global.dice5_val == 5:
			arrow +=1
			
		if global.dice1_val == 3:
			life +=1
		if global.dice2_val == 3:
			life +=1
		if global.dice3_val == 3:
			life +=1
		if global.dice4_val == 3:
			life +=1
		if global.dice5_val == 3:
			life +=1
		
		if life >= 3:
			$player/life1.visible = true
			$player/life2.visible = true
			$player/life3.visible = true
			
		if life == 2:
			$player/life1.visible = true
			$player/life2.visible = true
			$player/life3.visible = false
		
		if life  == 1:
			$player/life1.visible = true
			$player/life2.visible = false
			$player/life3.visible = false
		
		if life  == 0:
			$player/life1.visible = false
			$player/life2.visible = false
			$player/life3.visible = false
			
		if arrow == 0:
			$player/arrow1.visible = false
			$player/arrow2.visible = false
			$player/arrow3.visible = false
			
		if arrow == 1:
			$player/arrow1.visible = true
			$player/arrow2.visible = false
			$player/arrow3.visible = false
		
		if arrow  == 2:
			$player/arrow1.visible = true
			$player/arrow2.visible = true
			$player/arrow3.visible = false
		
		if arrow  == 3:
			$player/arrow1.visible = true
			$player/arrow2.visible = true
			$player/arrow3.visible = true
			
		cpt = 0
		
		
		


#func $RollDiceButton_clicked():
#	pass

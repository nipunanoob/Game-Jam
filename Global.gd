extends Node2D


var bg_music = 0
var victory = 0

func _input(event):
	if Input.is_action_pressed("reset") and get_tree().current_scene.name != "MainMenu":
		var reset = get_tree().reload_current_scene()

func _process(delta):
	if bg_music == 0 and get_tree().current_scene.name == "Level 1":
		$"BG Music".play()
		bg_music = 1
	if victory == 0 and get_tree().current_scene.name == "Level 5":
		$"BG Music".stop()
		$VictorySound.play()
		victory = 1
		

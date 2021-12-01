extends Node2D

func _process(delta):
	if Input.is_action_just_pressed('shoot'):
		$LevelStartTimer.start()
		$AnimationPlayer.play("Fade")
		


func _on_LevelStartTimer_timeout():
	get_tree().change_scene("res://Levels/Level 1.tscn")

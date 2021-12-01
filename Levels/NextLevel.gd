extends Sprite

	
func _on_Hitbox_body_entered(body):
	print('hit')
	if body.is_in_group("player"):
		get_tree().change_scene("res://Levels/Level " + str(int(get_tree().current_scene.name) + 1) + ".tscn")
		print("res://Levels/Level " + str(int(get_tree().current_scene.name) + 1) + ".tscn")

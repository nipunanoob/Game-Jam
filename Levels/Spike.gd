extends Area2D



func _on_Spike_body_entered(body):
	if body.is_in_group("player"):
		body.gravity_scale = 100
		get_parent().get_node("Player/AnimationPlayer").play("Death")
		$SpikeTimer.start()
		
	



func _on_SpikeTimer_timeout():
	get_tree().reload_current_scene()

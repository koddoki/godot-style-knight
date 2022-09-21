extends Area2D


func _on_DoorExit_body_entered(body: Node) -> void:
	var novaCena = load("res://ux/Vitoria.tscn").instance()
	get_tree().current_scene.add_child(novaCena)
	set_collision_mask_bit(0,0);
	print('doorExitVictory');

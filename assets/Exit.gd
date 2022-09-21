extends Area2D

func _on_Exit_body_entered(body: Node) -> void:
	var novaCena = load("res://ux/Vitoria.tscn").instance()
	get_tree().current_scene.add_child(novaCena)
	set_collision_layer_bit(0,0)
	set_collision_mask_bit(0,0)
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://ux/Niveis/Niveis.tscn")

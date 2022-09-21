extends Area2D

func _on_AreaDaMorte_body_entered(body: Node) -> void:
	if get_parent().get_node("Sprite").modulate == body.get_node("Sprite").modulate:
		body.queue_free();

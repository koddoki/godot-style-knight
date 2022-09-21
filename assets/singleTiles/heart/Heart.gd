extends Area2D


func _on_Heart_body_entered(body: Node) -> void:
	queue_free();

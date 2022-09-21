extends Button



func _on_SpawnaTutorial_pressed() -> void:
	var instancia = load("res://ux/inlevel/Tutorial.tscn").instance();
	get_tree().current_scene.add_child(instancia);

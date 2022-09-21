extends CanvasLayer

func _ready():
	$AnimationPlayer.play("prisma")
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(15), "timeout")
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene("res://ux/Main menu/Menu.tscn")

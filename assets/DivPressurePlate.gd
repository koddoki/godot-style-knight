extends Node2D
onready var childQtnd = get_child_count()

func verify_pressure_plate():
	for child in childQtnd:
		if get_child(child).ativated == 0:
			get_parent().get_node("door").process_class(["fill","color","red"])
			return
	get_parent().get_node("door").process_class(["fill","color","green"])

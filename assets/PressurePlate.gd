extends Sprite

export(Color, RGB) var color
var ativated = 0


func _ready():
	modulate = color


func _on_Area2D_area_exited(area):
	if area.name == "BoxCollision":
		ativated -= 1
		get_parent().verify_pressure_plate()


func _on_Area2D_area_entered(area):
	if area.name == "BoxCollision":
		ativated += 1
		get_parent().verify_pressure_plate()


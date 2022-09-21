extends Control

func _ready():
	pass

func _on_Nivel1_pressed():
	get_tree().change_scene("res://levels/level1/Node2D.tscn")

func _on_Nivel2_pressed():
	get_tree().change_scene("res://levels/level2/Level2.tscn")

func _on_Nivel3_pressed():
	get_tree().change_scene("res://levels/level3/Level3.tscn")

func _on_Nivel4_pressed():
	get_tree().change_scene("res://levels/level4/Level4.tscn")

func _on_Nivel5_pressed():
	get_tree().change_scene("res://levels/level5/Level5.tscn")

func _on_Nivel6_pressed():
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")
#TROCAR O NIVEL

func _on_Nivel7_pressed():
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")
#TROCAR O NIVEL

func _on_Nivel8_pressed():
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")
#TROCAR O NIVEL

func _on_HomeButton_pressed():
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")

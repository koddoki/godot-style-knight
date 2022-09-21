extends Control

func _ready():
	pass

func _on_StartButton_pressed():
	get_tree().change_scene("res://levels/level1/Node2D.tscn")

func _on_LevelsButton_pressed():
	get_tree().change_scene("res://ux/Niveis/Niveis.tscn")

func _on_CreditButton_pressed():
	get_tree().change_scene("res://ux/CreditGame/CreditGame.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

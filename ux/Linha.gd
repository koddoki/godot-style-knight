extends HBoxContainer


func _on_Button_pressed() -> void:
	OS.set_clipboard($MainText.text)

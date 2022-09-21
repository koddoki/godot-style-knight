extends CanvasLayer


func _ready() -> void:
	$JustifyContent.set_visible(false)
	$AlignItems.set_visible(false)
	$FlexDirection.set_visible(false)


func _on_JustifycontentButton_pressed() -> void:
	$JustifyContent.set_visible(true)
	$AlignItems.set_visible(false)
	$FlexDirection.set_visible(false)


func _on_AlignitemsButton_pressed() -> void:
	$JustifyContent.set_visible(false)
	$AlignItems.set_visible(true)
	$FlexDirection.set_visible(false)


func _on_FlexdirectionButton_pressed() -> void:
	$JustifyContent.set_visible(false)
	$AlignItems.set_visible(false)
	$FlexDirection.set_visible(true)


func _on_FlexboxButton_pressed() -> void:
	$JustifyContent.set_visible(true)
	$AlignItems.set_visible(false)
	$FlexDirection.set_visible(false)


func _on_Exit_button_up() -> void:
	_ready()

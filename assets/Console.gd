extends Panel


func _ready() -> void:
	pass

func _on_TextEdit_text_changed() -> void:
	get_parent().reset()
	get_parent().process_text(get_text())


func get_text():
	var conteudo = $MarginContainer/TextEdit.get_text()
	conteudo = conteudo.to_lower()
	
	var classe = RegEx.new()
	classe.compile("[.|#]([^:;\\s]+)\\s*{([^}]*)}")
	
	var propriedade = RegEx.new()
	propriedade.compile("([^:;\\s]+)\\s*:\\s*([^:;\\s]+)\\s*;")
	
	var array = []
	
	for result in classe.search_all(conteudo):
		var array2 = []
		array2.append(result.get_string(1))
		for result2 in propriedade.search_all(result.get_string(2)):
			array2.append(result2.get_string(1))
			array2.append(result2.get_string(2))
		array.append(array2)
	get_parent().past_text = array
	#print(array)
	return array

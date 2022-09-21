extends Node2D
var past_text = []


#aqui você adiciona as classes junto com o path pro objeto
var classes = {
	"player":"player",
	"door":"door",
	"moidy":"Moidy",
	"box":"Div",
	"caixa":"Div/Box"
}


func process_text(text):
	#print(text)
	for array in text:
		if array[0] in classes:
			
			get_node(classes[array[0]]).process_class(array)


func get_text():
	var conteudo = $Background/MarginContainer/TextEdit.get_text()
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
	past_text = array
	#print(array)
	return array


func reset():
	for array in past_text:
		var count = 0
		for  i in (array.size() - 1)/2:
			count+=1
			i+=count
			array[i+1] = "FILL"
	process_text(past_text)


func _on_HomeButton_pressed() -> void:
	get_tree().change_scene("res://ux/Main menu/Menu.tscn")

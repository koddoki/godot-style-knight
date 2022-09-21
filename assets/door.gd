extends StaticBody2D


func _ready() -> void:
	process_class(["FILL","color","red"])

func dor(positionx,positiony):
	pass

func process_class(a):
	var count = 0
	
	for  i in (a.size() - 1)/2:
		count+=1
		i+=count
		
		match a[i]:
			"color":
				var cor = validade_color(a[i+1])
				$Sprite.modulate = Color(cor[0],cor[1],cor[2])
				if a[0] == "door" or cor == [1,1,0]:
					pass
					
				
			"size":
				$door.scale = Vector2(a[i+1],a[i+1])
				print("cor")
			_:
				print("erro")
				break
	
	changeColor()


func validade_color(color):
	match color:
		"red":
			return [1,0,0]
		"blue":
			return [0,0,1]
		"green":
			return [0,1,0]
		"yellow":
			return [1,1,0]
		_:
			return [1,1,1]


func _on_TextEdit_text_changed() -> void:
	changeColor();


func changeColor():
	if  $Sprite.modulate == Color(0,1,0): # green OPEN
		set_collision_layer_bit(0,0);
		set_collision_mask_bit(0,0);
	elif $Sprite.modulate == Color(1,0,0): # red CLOSE
		set_collision_layer_bit(0,1);
		set_collision_mask_bit(0,1);
	elif $Sprite.modulate == Color(1,1,0): # yellow OPEN
		set_collision_layer_bit(0,0);
		set_collision_mask_bit(0,0);
		criaSaida();

func criaSaida():
	var novaCena = load("res://DoorExit.tscn").instance()
	get_tree().current_scene.add_child(novaCena)
	print('Saida criada!')

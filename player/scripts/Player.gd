extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()
var speed = 280
signal color_change

var player_control = true;
var alive = true;


func _process(delta):
	walk(delta);
	animation();


func walk(delta):
	if player_control:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up");
		
	velocity = direction.normalized() * speed;
	velocity = move_and_slide(velocity);

func animation():
	if alive:
		if Input.is_action_pressed("ui_right"):
			$Sprite.play("run");
			$Sprite.set_flip_h(false);
		elif Input.is_action_pressed("ui_left"):
			$Sprite.play("run");
			$Sprite.set_flip_h(true);
		else:
			$Sprite.play("idle");
	else:
		$Sprite.play("dead")


func process_class(a):
	var count = 0
	
	for  i in (a.size() - 1)/2:
		count+=1
		i+=count
		
		match a[i]:
			"color":
				validade_color(a[i+1])
				emit_signal("color_change")
				
			"height":
				scale.y = int(a[i+1])
			
			"width":
				scale.x = int(a[i+1])
			
			_:
				break


func validade_color(color):
	var regex = RegEx.new()
	regex.compile("#([0-9a-f]{8}|[0-9a-f]{6}|[0-9a-f]{3}|[0-9a-f]{4})\\z")
	var result = regex.search(color)
	if result:
		$Sprite.modulate = Color(result.get_string(1))
	else:
		match color:
			"red":
				$Sprite.modulate = Color.red 
			"blue":
				$Sprite.modulate = Color.blue
			"green":
				$Sprite.modulate = Color.green
			"yellow":
				$Sprite.modulate = Color.yellow
			"FILL":
				$Sprite.modulate = Color(1,1,1)
			_:
				$Sprite.modulate = Color(1,1,1)


func _on_TextEdit_text_changed() -> void:
	if $Sprite.modulate == Color(1,1,0): # yellow
		var novaCena = load("res://ux/Vitoria.tscn").instance()
		get_tree().current_scene.add_child(novaCena)
		print("AUTO VITORIA HEHE");
		

func _on_TextEdit_focus_entered() -> void:
	player_control = false;

func _on_TextEdit_focus_exited() -> void:
	player_control = true;

func dor(var enemyposx, enemyposy):
	print("dor")
	set_modulate(Color(1,0.3,0.3,0.5))
	player_control = false
	alive = false;
	
	if position.x < enemyposx:
		direction.x = -1
	elif position.x > enemyposx:
		direction.x = 1
	if position.y < enemyposy:
		direction.y = 1
	elif position.y > enemyposy:
		direction.y = -1
	speed = 500

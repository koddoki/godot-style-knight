extends RigidBody2D

export var ordem = 0
var containerSizeX = 0
var containerSizeY = 0
var offSetX = 0
var offSetY = 0
var boxSizeX = 55
var boxSizeY = 80

onready var parent = get_parent()

func process_class(a):
	var count = 0
	var halfcontainerX = containerSizeX/2
	var halfcontainerY = containerSizeY/2
	
	for  i in (a.size() - 1)/2:
		count+=1
		i+=count
		
		var increment = 0
		var local = 0
		
		match a[i]:
			
			"align-self":
				match a[i+1]:
					"center":
						local = halfcontainerY - boxSizeY/2
						position.y = local - offSetY
					
					"start":
						local = 0
						position.y = local - offSetY
					
					"end":
						local = containerSizeY - boxSizeY
						position.y = local - offSetY
			
			"order":
				match a[i+1]:
					_:
						ordem = int(a[i+1])
						parent.sort_boxes()
						parent.reload()
					"FILL":
						ordem = 0
						parent.sort_boxes()
			_:
				break


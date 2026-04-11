extends Node2D

var global = Global.new()
var local_cfg := {}

#create
func create_defatult_cfg() -> Dictionary :
	var to_ret = {}
	
	to_ret = {
		"max_hand" : 10 ,
		"current_hand" : [
			{  }
		]
	}
	
	return to_ret
#create

#read
#read

#update
#update

#delete
#delte

#methods
func draw_deck() -> Array :
	
	return []
#methods

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Window :
		local_cfg = create_defatult_cfg()
	
	pass # Replace with function body.

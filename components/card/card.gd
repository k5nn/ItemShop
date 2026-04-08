extends Control
class_name Card

signal card_highlighted( inst : Card , cfg : Dictionary )
signal card_deselected( inst : Card , cfg : Dictionary )

var local_cfg := {}

#create
func create_default_cfg() -> Dictionary:
	var global = Global.new()
	var default_quality = global.defaults.card.quality
	var default_battle = global.defaults.card.battle
	var ret_dict = global.defaults.card.ret_dict
	
	#ret_dict.merge( default_quality )
	ret_dict.merge( default_battle )
	
	if ret_dict.mode == "Quality" :
		var to_merge = {
			"to_serialize" : global.defaults.card.quality.to_serialize ,
			"populate_args" : {
				"bg" : ret_dict.bg ,
				"mode" : ret_dict.mode ,
				"name" : ret_dict.name ,
				"base_value" : ret_dict.base_value ,
				"plus_multiplier" : ret_dict.plus_multiplier ,
				"effects" : ret_dict.effects
			}
		}
		ret_dict.merge( to_merge )
	elif ret_dict.mode == "Battle" :
		var to_merge = {
			"to_serialize" : global.defaults.card.battle.to_serialize ,
			"populate_args" : {
				"bg" : ret_dict.bg ,
				"mode" : ret_dict.mode ,
				"name" : ret_dict.name ,
				"effects" : ret_dict.effects
			}
		}
		ret_dict.merge( to_merge )
	
	return ret_dict
#create

#read
func verify_cfg() -> void :
	if !local_cfg.layouts.has( local_cfg.mode ) :
		printerr( "invalid mode" )
		get_tree().quit( 11 )
	
	var required_keys := []
	
	if local_cfg.mode == "Quality" :
		required_keys = [ "bg" , "mode" , "name" , "base_value" , "plus_multiplier" , "effects" ]
	
	if local_cfg.mode == "Battle" :
		required_keys = [ "bg" , "mode" , "name" , "effects" ]
		
	required_keys.append_array( [ "to_serialize" , "populate_args" ] )
	
	for key in required_keys :
		if local_cfg.get( key , null ) == null :
			printerr( "card > verify_cfg > missing key : " + key )
			get_tree().quit( 12 )
#read

#update
#update

#methods
func apply_cfg() -> void :
	
	verify_cfg()
	
	if local_cfg.layouts[ local_cfg.mode ] is PackedScene :
		
		local_cfg.set( "instance" , local_cfg.layouts[ local_cfg.mode ].instantiate() )
		var to_serialize := {}
		var populate_args := {}
		
		local_cfg.instance.create_keys( local_cfg.to_serialize )
		local_cfg.instance.populate_layout( local_cfg.populate_args )
		add_child( local_cfg.instance )
			
#methods

#events
func _on_mouse_entered() -> void:
	if self.get_parent() is Window :
		print( "window mode" )
		print( local_cfg )
		return
	emit_signal( "card_highlighted" , self , local_cfg )

func _on_mouse_exited() -> void:
	if self.get_parent() is Window :
		print( "window mode" )
		print( local_cfg )
		return
	emit_signal( "card_deselected" , self , local_cfg )
#events

func _ready() -> void:	
	if self.get_parent() is Window :
		local_cfg = create_default_cfg()
		apply_cfg()
		self.position = get_viewport_rect().size * 0.25
	
	local_cfg.set( "orig_position" , self.position )

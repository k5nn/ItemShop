extends Control
class_name Card

signal card_highlighted( inst : Card , cfg : Dictionary )
signal card_deselected( inst : Card , cfg : Dictionary )

var local_cfg := {}

#create
func create_default_cfg() -> Dictionary:
	const default_quality = {
		"bg" : preload("res://assets/Card/Quality/Base_Quality.png") ,
		"mode" : "Quality" ,
		"name" : "Provenance" ,
		"base_value" : 10 ,
		"plus_multiplier" : 0 ,
		"modifiers" : [ "R" ]
	}
	const default_battle = {
		"bg" : preload("res://assets/Card/Battle/Base_Battle.png") ,
		"mode" : "Battle" ,
		"name" : "Strike" ,
		"effects" : { 
			"HP_damage" : 6 
		}
	}
	var ret_dict = {
		"layouts" : {
			"Quality" : preload( "res://components/card/quality_layout.tscn" ) ,
			"Battle" : preload( "res://components/card/battle_layout.tscn" ) ,
			"Negotiation" : true
		}
	}
	#ret_dict.merge( default_quality )
	ret_dict.merge( default_battle )
	
	return ret_dict
#create

#read
func verify_cfg() -> void :
	if !local_cfg.layouts.has( local_cfg.mode ) :
		printerr( "invalid mode" )
		get_tree().quit( 11 )
	
	var required_keys := []
	
	if local_cfg.mode == "Quality" :
		required_keys = [ "bg" , "mode" , "name" , "base_value" , "plus_multiplier" , "modifiers" ]
	
	if local_cfg.mode == "Battle" :
		required_keys = [ "bg" , "mode" , "name" , "effects" ]
	
	for key in required_keys :
		if local_cfg.get( key , null ) == null :
			printerr( "missing key : " + key )
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
		
		if local_cfg.mode == "Quality" :
			to_serialize = {
				"Provenance" : preload("res://assets/Card/Quality/Provenance.png") , 
				"Utility" : preload("res://assets/Card/Quality/Utility.png") , 
				"Durability" : preload("res://assets/Card/Quality/Durability.png") , 
				"Craftsmanship" : preload("res://assets/Card/Quality/Craftsmanship.png") ,
				"R" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"G" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"B" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"Y" : preload( "res://assets/Card/Quality/modifier.png" ) ,
			}
			populate_args = {
				"bg" : local_cfg.bg ,
				"mode" : local_cfg.mode ,
				"name" : local_cfg.name ,
				"base_value" : local_cfg.base_value ,
				"plus_multiplier" : local_cfg.plus_multiplier ,
				"modifiers" : local_cfg.modifiers
			}
		elif local_cfg.mode == "Battle" :
			to_serialize = {
				"Strike" : preload( "res://assets/Card/Battle/CardArt.png" ) ,
				"HP_damage" : "Deal " + str( local_cfg.effects[ "HP_damage" ] ) + " damage"
			}
			populate_args = {
				"bg" : local_cfg.bg ,
				"mode" : local_cfg.mode ,
				"name" : local_cfg.name ,
				"effects" : local_cfg.effects
			}
		elif local_cfg.mode == "Negotiation" :
			to_serialize = {}
			populate_args = {}
			
		local_cfg.instance.create_keys( to_serialize )
		local_cfg.instance.populate_layout( populate_args )
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

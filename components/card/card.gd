extends Control
class_name Card

signal card_highlighted( inst : Card , cfg : Dictionary )
signal card_deselected( inst : Card , cfg : Dictionary )

const layouts = {
	"Quality" : preload( "res://components/card/negotiation_layout.tscn" ) ,
	"Battle" : true ,
	"Negotiation" : true
}

var local_cfg := {}

#create
func get_default_cfg() -> Dictionary:
	return {
		"asset" : preload("res://assets/Card/Base.png") ,
		"mode" : "quality" ,
		"suit" : "Provenance" ,
		"base_value" : 10 ,
		"plus_multiplier" : 0 ,
		"modifiers" : [ "R" ]
	}
#create

#update
func verify_and_set_cfg( cfg ) -> void :
	
	if !layouts.has( cfg.mode ) :
		printerr( "invalid mode" )
		get_tree().quit( 1 )
	
	if layouts[ cfg.mode ] is PackedScene :
		local_cfg.set( "instance" , layouts[ cfg.mode ].instantiate() )
		local_cfg.instance.add_assets( {
			"Provenance" : preload("res://assets/Card/Provenance.png") , 
			"Utility" : preload("res://assets/Card/Utility.png") , 
			"Durability" : preload("res://assets/Card/Durability.png") , 
			"Craftsmanship" : preload("res://assets/Card/Craftsmanship.png") ,
			"R" : preload( "res://assets/Card/modifier.png" ) ,
			"G" : preload( "res://assets/Card/modifier.png" ) ,
			"B" : preload( "res://assets/Card/modifier.png" ) ,
			"Y" : preload( "res://assets/Card/modifier.png" ) ,
		} )
		add_child( local_cfg.instance )
	
	local_cfg = cfg
	#apply_cfg( cfg )

#func apply_cfg( cfg ) -> void :
	#
	#if cfg.mode == "quality" :
		
		#add_dots( local_cfg.modifiers )

#func update_suit( target_suit : String ) :
	#validate_suit( target_suit )
	#local_cfg.suit = target_suit
	#$SuitIcon.texture = suit_assets[ target_suit ]
#
#func update_base_value( base_value : int ) :
	#local_cfg.base_value = base_value
	#$BaseValue.text = str( base_value )
#
#func update_multiplier( plus_multiplier : int ) :
	#local_cfg.plus_modifier = plus_multiplier
	#$Multiplier.text = "+x" + str( plus_multiplier )
#update

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
		verify_and_set_cfg( get_default_cfg() )
		self.position = get_viewport_rect().size * 0.25
		
	$SuitIcon.position = $Background.texture.get_size() * 0.05
	$Multiplier.position = $Background.texture.get_size() * Vector2( 0.55 , 0.05 )
	$BaseValue.position =  $Background.texture.get_size() * Vector2( 0.1 , 0.85 )
	$DotContainer.position = $Background.texture.get_size() * Vector2( 0.3 , 0.15 )
	
	local_cfg.set( "orig_position" , self.position )

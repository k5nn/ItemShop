extends Control
class_name Card

signal card_highlighted( inst : Card , cfg : Dictionary )
signal card_deselected( inst : Card , cfg : Dictionary )

const suit_assets = {
	"Provenance" : preload("res://assets/Card/Provenance.png") , 
	"Utility" : preload("res://assets/Card/Utility.png") , 
	"Durability" : preload("res://assets/Card/Durability.png") , 
	"Craftsmanship" : preload("res://assets/Card/Craftsmanship.png") 
}

const dot_assets = {
	"R" : preload( "res://assets/Card/modifier.png" ) ,
	"G" : preload( "res://assets/Card/modifier.png" ) ,
	"B" : preload( "res://assets/Card/modifier.png" ) ,
	"Y" : preload( "res://assets/Card/modifier.png" ) ,
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

#read
func validate_suit( suit : String ) :
	if !suit_assets.has( suit ) :
		printerr( "invalid suit" )
		get_tree().quit( 1 )

func validate_modifier( modifiers : Array ) :
	if modifiers.size() > 3 :
		printerr( "too many modifiers" )
		get_tree().quit( 2 )
	
	for modifier in modifiers :
		if !dot_assets.has( modifier ) :
			printerr( "Invalid dot modifier" )
			get_tree().quit( 3 )
#read

#update
func add_dots( modifiers ) :
	for child in $DotContainer.get_children() :
		child.queue_free()
	
	for modifier in modifiers :
		var dot = TextureRect.new()
		dot.texture = dot_assets[ modifier ]
		$DotContainer.add_child( dot )

func verify_and_set_cfg( cfg ) -> void :
	
	const valid_modes = { "quality" : true , "battle" : true , "negotiation" : true }
	
	if !valid_modes.has( cfg.mode ) :
		printerr( "invalid mode" )
		get_tree().quit( 1 )
		
	if cfg.mode == "quality" :
		validate_suit( cfg.suit )
		if cfg.has( "dot_modifier" ) :
			validate_modifier( cfg.modifiers )
	
	local_cfg = cfg
	apply_cfg( cfg )

func apply_cfg( cfg ) -> void :
	
	if cfg.mode == "quality" :
		$SuitIcon.texture = suit_assets[ cfg.suit ]
		$Multiplier.text = "x+" + str( cfg.plus_multiplier )
		$BaseValue.text = str( cfg.base_value )
		add_dots( local_cfg.modifiers )

func update_suit( target_suit : String ) :
	validate_suit( target_suit )
	local_cfg.suit = target_suit
	$SuitIcon.texture = suit_assets[ target_suit ]

func update_base_value( base_value : int ) :
	local_cfg.base_value = base_value
	$BaseValue.text = str( base_value )

func update_multiplier( plus_multiplier : int ) :
	local_cfg.plus_modifier = plus_multiplier
	$Multiplier.text = "x+" + str( plus_multiplier )
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

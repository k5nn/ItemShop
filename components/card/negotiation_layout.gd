extends Control

var asset_dictionary : Dictionary

#create
func add_assets( assets : Dictionary ) :
	for key in assets :
		asset_dictionary.set( key , assets[ key ] )

func add_dots( dot_assets : Dictionary , modifiers : Array ) :
	for child in $DotContainer.get_children() :
		child.queue_free()
	
	for modifier in modifiers :
		var dot = TextureRect.new()
		dot.texture = dot_assets[ modifier ]
		$DotContainer.add_child( dot )
#create

#read
func validate_suit( suit : String ) :
	if !asset_dictionary.has( suit ) :
		printerr( "invalid suit" )
		get_tree().quit( 1 )

func validate_base_value( base_value : int ) :
	if base_value < 0 :
		printerr( "invalid multiplier plus" )
		get_tree().quit( 2 )

func validate_plus_multiplier( multi : int ) :
	if multi < 0 :
		printerr( "invalid multiplier plus" )
		get_tree().quit( 3 )

func validate_modifier( modifiers : Array ) :
	if modifiers.size() > 3 :
		printerr( "too many modifiers" )
		get_tree().quit( 4 )
	
	for modifier in modifiers :
		if !asset_dictionary.has( modifier ) :
			printerr( "Invalid dot modifier" )
			get_tree().quit( 4 )
#read

func populate_layout( suit : String , plus_mult : int , base_val : int , modifiers : Array ) :
	$SuitIcon.texture = asset_dictionary[ suit ]
	$Multiplier.text = "+x" + str( plus_mult )
	$BaseValue.text = str( base_val )
	
func _ready() -> void:
	pass

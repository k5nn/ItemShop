extends Control

var asset_dictionary := {}
var global = Global.new()

#create
func create_keys( assets : Dictionary ) :
	assert( !assets.is_empty() )
	
	for key in assets :
		
		if global.debug_obj.card.key_output :
			print( key )
			
		asset_dictionary.set( key , assets[ key ] )
#create

#read
func validate_generic_str( generic : String ) :
	
	if global.debug_obj.card.validate_output :
		print( { 
			"dict" : asset_dictionary , 
			"generic" : generic , 
		}  )
	assert( asset_dictionary.has( generic ) )

func validate_generic_int( generic : int , lo_limit : int , hi_limit : int ) :
	
	if global.debug_obj.card.validate_output :
		print( {
			"limits" : { "lo" : lo_limit , "hi" : hi_limit } ,
			"generic" : generic ,
			"lo_not_hit" : generic > lo_limit ,
			"hi_not_hit" : generic < hi_limit
		} )
	assert( generic > lo_limit and generic < hi_limit )

func validate_generic_effects( generic : Array , max_size : int ) :
	if global.debug_obj.card.validate_output :
		print( {
			"dict" : asset_dictionary ,
			"generic" : generic ,
			"generic_size" : generic.size()
		} )
	assert( generic.size() <= max_size )

	for modifier in generic : 
		assert( asset_dictionary.has( modifier ) )
	return
#read

#update
func add_modifiers( modifiers : Array ) :
	if modifiers.is_empty() :
		return
	
	for child in $DotContainer.get_children() :
		child.queue_free()
	
	for modifier in modifiers :
		var dot = TextureRect.new()
		dot.texture = asset_dictionary[ modifier ]
		$DotContainer.add_child( dot )
#update

#delete
#delete

#methods
func populate_layout( args : Dictionary ) :
		
	$Background.texture = args.bg
	
	if args.mode == "Quality" :
		
		validate_generic_str( args.name )
		validate_generic_int( args.value , 0 , 10000 )
		validate_generic_effects( args.effects , 3 )
		
		$SuitIcon.position = $Background.texture.get_size() * 0.05
		$SuitIcon.texture = asset_dictionary[ args.name ]
		
		$BaseValue.position =  $Background.texture.get_size() * Vector2( 0.05 , 0.7 )
		$BaseValue.text = str( args.value )
		
		$DotContainer.position = $Background.texture.get_size() * Vector2( 0.3 , 0.15 )
		add_modifiers( args.effects )
		return
	
	if args.mode == "Action" :
		
		validate_generic_str( args.name )
		validate_generic_effects( args.effects , 2 )
		
		$CardArt.position = $Background.texture.get_size() * 0.05
		$CardArt.texture = asset_dictionary[ args.name ]
		
		$Description.position = $Background.texture.get_size() * Vector2( 0.3 , 0.6 )
		$Description.custom_minimum_size = $Background.texture.get_size() * Vector2( 0.95 , 0.35 )
		for effect in args.effects :
			$Description.text += asset_dictionary[ effect ] + "\n"
		return
		
#methods

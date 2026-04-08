extends Control

var asset_dictionary := {}

#create
func create_keys( assets : Dictionary ) :
	for key in assets :
		asset_dictionary.set( key , assets[ key ] )
#create

#read
func validate_generic_str( generic : String ) :
	if !asset_dictionary.has( generic ) :
		printerr( "Invalid : " + generic )
		get_tree().quit( 1 )

func validate_generic_int( generic : int , lo_limit : int , hi_limit : int ) :
	if generic < lo_limit :
		printerr( "Lo Limit : " + str(generic) )
		get_tree().quit( 2 )
	
	if generic > hi_limit :
		printerr( "Hi Limit : " + str( generic ) )
		get_tree().quit( 2 )

func validate_generic_effects( effects : Variant ) :
	
	if effects is Dictionary :
		if effects.is_empty() :
			printerr( "No Effects" )
			get_tree().quit( 4 )
		
		for effect in effects :
			if !asset_dictionary.has( effect ) :
				printerr( "Invalid Effect" )
				get_tree().quit( 4 )
			
			validate_generic_int( effects[ effect ] , -100 , 100 )
		return
				
	if effects is Array :
		if effects.size() > 3 :
			printerr( "Too many modifiers" )
			get_tree().quit( 4 )
	
		for modifier in effects :
			if !asset_dictionary.has( modifier ) :
				printerr( "Invalid dot modifier" )
				get_tree().quit( 4 )
		return
	
#read

#update
func add_modifiers( modifiers : Dictionary ) :
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
		validate_generic_int( args.base_value , 0 , 10000 )
		validate_generic_int( args.plus_multiplier , 0 , 10 )
		validate_generic_effects( args.effects )
		
		$SuitIcon.position = $Background.texture.get_size() * 0.05
		$SuitIcon.texture = asset_dictionary[ args.name ]
		
		$Multiplier.position = $Background.texture.get_size() * Vector2( 0.3 , 0.05 )
		$Multiplier.text = "+x" + str( args.plus_multiplier )
		
		$BaseValue.position =  $Background.texture.get_size() * Vector2( 0.05 , 0.7 )
		$BaseValue.text = str( args.base_value )
		
		$DotContainer.position = $Background.texture.get_size() * Vector2( 0.3 , 0.15 )
		add_modifiers( args.effects )
		return
	
	if args.mode == "Battle" :
		
		validate_generic_str( args.name )
		validate_generic_effects( args.effects )
		
		$CardArt.position = $Background.texture.get_size() * 0.05
		$CardArt.texture = asset_dictionary[ args.name ]
		
		$Description.position = $Background.texture.get_size() * Vector2( 0.3 , 0.6 )
		$Description.custom_minimum_size = $Background.texture.get_size() * Vector2( 0.95 , 0.35 )
		for effect in args.effects :
			$Description.text = asset_dictionary[ effect ] + "\n"
		return
		
#methods

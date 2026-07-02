extends Node2D

var global = Global.new()
var local_cfg := {}

#create
func create_defatult_cfg() -> Dictionary :
	return global.defaults.scopa
#create

#read
func read_cfg( import_cfg ) :
	local_cfg = import_cfg
	
	assert( import_cfg.deck is Array , str( import_cfg.deck ) )
	assert( import_cfg.board.floor is Set , str( import_cfg.board ) )
	assert( import_cfg.player.hand is Set , str( import_cfg.player ) )
	assert( import_cfg.opponent.hand is Set , str( import_cfg.opponent ) )
	
	for card in import_cfg.deck :
		if card is CardShell :
			$Deck.add_child( card )
			
	for card in import_cfg.board.floor.values() :
		if card is CardShell :
			self.add_child( card )
	
	for card in import_cfg.player.hand.values() :
		if card is CardShell :
			self.add_child( card )
			
	for card in import_cfg.opponent.hand.values() :
		if card is CardShell :
			self.add_child( card )
	
#read

#update
func draw_card( to_draw : int , dest_set : Set ) :
	for draws in range( to_draw ) :
		if local_cfg.deck.is_empty() :
			if to_draw == 1 :
				return null
			break
		var drawn = local_cfg.deck.pop_back()
		dest_set.add( drawn )
		
		if to_draw == 1 :
			return drawn
#update

#delete
#delete

#methods
func calc_slice() -> Vector2 :
	return get_viewport_rect().size / Vector2( 
		global.scopa_dict.ui.x_slices , global.scopa_dict.ui.y_slices 
	)

func position_pile( 
	slice_start : Vector2 , 
	pile : Array , 
	offset : Vector2 ,
	to_toggle : bool
	) -> void :
	var card_cnt = 0
	
	for card in pile :
		assert( card is CardShell )
		
		var resolved = card.resolve_art( card.local_cfg.visual , to_toggle )
		card.position = calc_slice() * ( slice_start + ( offset * card_cnt ) )
		card_cnt += 1
		
		card.local_cfg.visual.update_art( resolved[ "art" ] )

func position_draw_pile() :
	position_pile( Vector2( 1 , 3 ) , local_cfg.deck , Vector2( 0 , -0.01 ) , false )

func position_piles() :
	
	position_draw_pile()
	
	if local_cfg.board.floor.is_empty() :
		draw_card( 4 , local_cfg.board.floor )
		
	position_pile( Vector2( 2.5 , 3 ) , local_cfg.board.floor.values() , Vector2( 1 , 0 ) , true )
	
	if local_cfg.player.hand.is_empty() :
		draw_card( 3 , local_cfg.player.hand )
		
	position_pile( Vector2( 3 , 5.5 ) , local_cfg.player.hand.values() , Vector2( 1 , 0 ) , true )
	
	if local_cfg.opponent.hand.is_empty() :
		draw_card( 3 , local_cfg.opponent.hand )
		
	position_pile( Vector2( 3 , 0.5 ) , local_cfg.opponent.hand.values() , Vector2( 1 , 0 ) , false )
#methods

#eventsposition_piles
func _input(event: InputEvent) -> void:
	print( event )
#events

#animations
func animate_deck_draw( 
	source : Array , 
	dest_set : Set , 
	slice_start : Vector2 , 
	offset : Vector2 , 
	duration : float
	) :
	if source.size() == 0 :
		return
		
	var drawn = source.pop_back()
	var tween = create_tween()
	var end_pos := Vector2.ZERO
	dest_set.add( drawn )
	end_pos = calc_slice() * ( slice_start + ( offset * dest_set.size() ) )
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property( drawn , "position" , end_pos , duration )
#animations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Window :
		local_cfg = create_defatult_cfg()
		local_cfg.deck = global.create_random_deck( global.scopa_dict.game.init_is_hidden_state )
		read_cfg( local_cfg )
		position_piles()
	
	

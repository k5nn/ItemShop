extends Node2D

var global = Global.new()
var local_cfg := {}

#create
func create_defatult_cfg() -> Dictionary :
	var to_ret = {}
	to_ret = global.defaults.scopa
	return to_ret

func generate_deck() -> Array :
	var gen_params = {
		"suits" : global.suits ,
		"numbers" : global.values ,
	}
	var to_ret = []
	
	for suit in gen_params.suits :
		for num in gen_params.numbers :
			to_ret.append( { "suit" : suit , "value" : num } )
	
	assert( to_ret.size() == 40 )
		
	to_ret.shuffle()
	
	return to_ret
#create

#read
func read_card_pos( pos : int ) -> Dictionary :
	return local_cfg.deck[ pos ]
#read

#update
func draw_card( to_draw : int ) -> Array :
	var to_ret = []
	
	for draws in range( to_draw ) :
		if local_cfg.deck.is_empty() :
			break
		to_ret.append( local_cfg.deck.pop_back() )
		
	return to_ret
#update

#delete
#delete

#methods
#methods

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Window :
		local_cfg = create_defatult_cfg()
		local_cfg.deck = generate_deck()
		local_cfg.board.floor = draw_card( 4 )
		local_cfg.player.hand = draw_card( 3 )
		local_cfg.opponent.hand = draw_card( 3 )
	
	pass # Replace with function body.

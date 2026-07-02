extends Node
class_name Global

var debug_obj = {
	"enabled" : true ,
	"case" : 2 ,
	"playingcard" : {
		"settings" : {
			"art" : preload("res://assets/Card/Suits/Art/Coin.png") ,
			"rank" : preload( "res://assets/Card/Suits/Ranks/RED_8.png" ) ,
			"suit" : preload( "res://assets/Card/Suits/Icons/coins.png" )
		} ,
		"ready" : false
	} ,
	"shell" : { 
		"settings" : {
			"play" : {
				"mode" : "playing" ,
				"suit" : "Coin" ,
				"rank" : 8 ,
				"front" : "Default" ,
				"back" : "Default" ,
				"is_hidden" : false ,
				"drag_enabled" : false ,
			}
		} ,
		"event_out" : false ,
		"create_keys" : false ,
		"update_tooltip_text" : false ,
		"ready" : false ,
		"anim_debug" : true
	} ,
	"scopa" : {
		"settings" : {
			"stateless" : {
				"deck" : [] ,
				"board" : {
					"floor" : Set.new()
				} ,
				"player" : {
					"hand" : Set.new()
				} ,
				"opponent" : {
					"hand" : Set.new()
				}
			} ,
			"stateful" : {
				"deck" : [
					{ "suit" : "Sword" , "rank" : 10 } ,
					{ "suit" : "Cup" , "rank" : 1 } ,
					{ "suit" : "Coin" , "rank" : 10 } ,
					{ "suit" : "Wand" , "rank" : 5 } ,
					{ "suit" : "Sword" , "rank" : 1 } ,
					{ "suit" : "Coin" , "rank" : 9 } ,
					{ "suit" : "Wand" , "rank" : 4 } ,
					{ "suit" : "Cup" , "rank" : 2 } ,
					{ "suit" : "Sword" , "rank" : 9 } ,
					{ "suit" : "Wand" , "rank" : 3 } ,
					{ "suit" : "Cup" , "rank" : 3 } ,
					{ "suit" : "Coin" , "rank" : 8 } ,
					{ "suit" : "Sword" , "rank" : 2 } ,
					{ "suit" : "Cup" , "rank" : 4 } ,
					{ "suit" : "Wand" , "rank" : 2 } ,
					{ "suit" : "Coin" , "rank" : 7 } ,
					{ "suit" : "Sword" , "rank" : 8 } ,
					{ "suit" : "Coin" , "rank" : 6 } ,
					{ "suit" : "Wand" , "rank" : 10 } ,
					{ "suit" : "Cup" , "rank" : 6 } ,
					{ "suit" : "Coin" , "rank" : 5 } ,
					{ "suit" : "Sword" , "rank" : 7 } ,
					{ "suit" : "Sword" , "rank" : 4 } ,
					{ "suit" : "Cup" , "rank" : 9 } ,
					{ "suit" : "Sword" , "rank" : 6 } ,
					{ "suit" : "Wand" , "rank" : 8 } ,
					{ "suit" : "Coin" , "rank" : 3 } ,
					{ "suit" : "Sword" , "rank" : 5 } ,
					{ "suit" : "Cup" , "rank" : 8 } ,
					{ "suit" : "Wand" , "rank" : 6 } ,
				] ,
				"board" : {
					"floor" : [
						{ "suit" : "Cup" , "rank" : 10 } ,
						{ "suit" : "Coin" , "rank" : 2 } ,
						{ "suit" : "Wand" , "rank" : 9 } ,
						{ "suit" : "Coin" , "rank" : 1 }
					]
				} ,
				"player" : {
					"hand" : [
						{ "suit" : "Cup" , "rank" : 7 } ,
						{ "suit" : "Wand" , "rank" : 7 } ,
						{ "suit" : "Coin" , "rank" : 4 }
					]
				} ,
				"opponent" : {
					"hand" : [
						{ "suit" : "Cup" , "rank" : 5 } ,
						{ "suit" : "Wand" , "rank" : 1 } ,
						{ "suit" : "Sword" , "rank" : 3 } 
					]
				} ,
			"turn_ctr" : 0
			}
		} ,
		"load_cfg" : true ,
		"create_deck" : false ,
		"position_pile" : true , 
		"ready" : false
	}
}

var defaults = {
	"playingcard" : {
		"art" : preload("res://assets/Card/Suits/Art/Coin.png") ,
		"rank" : preload( "res://assets/Card/Suits/Ranks/RED_8.png" ) ,
		"suit" : preload( "res://assets/Card/Suits/Icons/coins.png" )
	} ,
	"shell" : {
		"play" : {
			"mode" : "playing" ,
			"suit" : "Coin" ,
			"rank" : 8 ,
			"front" : "Default" ,
			"back" : "Default" ,
			"is_hidden" : false , 
			"drag_enabled" : false ,
		}
	} ,
	"scopa" : {
		"deck" : [] ,
		"board" : {
			"floor" : Set.new()
		} ,
		"player" : {
			"hand" : Set.new()
		} ,
		"opponent" : {
			"hand" : Set.new()
		}
	}
}

const playing_dict := {
	"scene" : preload( "res://components/card/playingcard.tscn" ) ,
	"suit" : {
		"Coin" : preload( "res://assets/Card/Suits/Icons/coins.png" ) ,
		"Sword" : preload( "res://assets/Card/Suits/Icons/sword.png" ) ,
		"Cup" : preload( "res://assets/Card/Suits/Icons/cups.png" ) ,
		"Wand" : preload( "res://assets/Card/Suits/Icons/wand.png" )
	} ,
	"rank" : {
		"1" : preload( "res://assets/Card/Suits/Ranks/RED_1.png" ) ,
		"2" : preload( "res://assets/Card/Suits/Ranks/RED_2.png" ) ,
		"3" : preload( "res://assets/Card/Suits/Ranks/RED_3.png" ) ,
		"4" : preload( "res://assets/Card/Suits/Ranks/RED_4.png" ) ,
		"5" : preload( "res://assets/Card/Suits/Ranks/RED_5.png" ) ,
		"6" : preload( "res://assets/Card/Suits/Ranks/RED_6.png" ) ,
		"7" : preload( "res://assets/Card/Suits/Ranks/RED_7.png" ) ,
		"8" : preload( "res://assets/Card/Suits/Ranks/RED_8.png" ) ,
		"9" : preload( "res://assets/Card/Suits/Ranks/RED_9.png" ) ,
		"10" : preload( "res://assets/Card/Suits/Ranks/RED_10.png" )
	} ,
	"art" : {
		"front" : {
			"Default" : {
				"Coin" : [
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" ) ,
					preload( "res://assets/Card/Suits/Art/Coin.png" )
				] ,
				"Cup" : [
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" ) ,
					preload( "res://assets/Card/Suits/Art/Cup.png" )
				] ,
				"Sword" : [
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" ) ,
					preload( "res://assets/Card/Suits/Art/Sword.png" )
				] ,
				"Wand" : [
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" ) ,
					preload( "res://assets/Card/Suits/Art/Wand.png" )
				]
			}
		} ,
		"back" : {
			"Default" : preload( "res://assets/Card/Suits/Art/Hidden.png" )
		}
	} , 
	"art_hidden" : {
		"Default" : preload( "res://assets/Card/Suits/Art/Hidden.png" )
	} ,
	"drag_enabled" : false
}

const scopa_dict = {
	"ui" : {
		"x_slices" : 8 ,
		"y_slices" : 8
	} ,
	"game" : {
		"suits" : [ "Sword" , "Coin" , "Cup" , "Wand" ] ,
		"ranks" : [ 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 ] ,
		"front" : "Default" ,
		"back" : "Default" ,
		"init_is_hidden_state" : true
	}
}

var game_dict = {
	
}

#asserts
func assert_arr_size( target : Array , min_size : int , max_size : int , caller : String ) :
	assert( target.size() >= min_size and target.size() <= max_size , caller )

func assert_int( target : int , lo : int , hi : int , caller : String ) :
	assert( target >= lo and target <= hi , caller )
#asserts

func create_random_deck( is_hidden_state : bool ) -> Array :
	var shell = preload( "res://components/card/Shell.tscn" )
	var gen_params = {
		"suits" : scopa_dict.game.suits ,
		"ranks" : scopa_dict.game.ranks ,
	}
	var to_ret = []
	
	for suit in gen_params.suits :
		for rank in gen_params.ranks :
			var instance = shell.instantiate()
			instance.create_keys( {
				"mode" : "playing" , 
				"suit" : suit ,
				"rank" : rank ,
				"front" : scopa_dict.game.front ,
				"back" : scopa_dict.game.back ,
				"is_hidden" : is_hidden_state ,
				"drag_enabled" : playing_dict.drag_enabled
			} )
			to_ret.append( instance )
			
	assert( to_ret.size() == 40 )
	to_ret.shuffle()
	
	return to_ret

func process_piles( input_deck : Array , is_hidden_state : bool ) -> Array :
	var shell = preload( "res://components/card/Shell.tscn" )
	var to_ret = []
	
	for card in input_deck :
		if card.has( "suit" ) and card.has( "rank" ) :
			card.set( "mode" , "playing" )
		
		var instance = shell.instantiate()
		card.set( "front" , scopa_dict.game.front )
		card.set( "back" , scopa_dict.game.back )
		card.set( "is_hidden" , is_hidden_state )
		card.set( "drag_enabled" , playing_dict.drag_enabled )
		instance.create_keys( card )
		to_ret.append( instance )
	
	return to_ret
	

func debug_run() :
	if debug_obj.case == 0 :
		var playing_card_scene = preload( "res://components/card/playingcard.tscn" )
		var instance = playing_card_scene.instantiate()
		instance.create_keys( debug_obj.playingcard.settings )
		self.add_child( instance )
	elif debug_obj.case == 1 :
		var shell_scene = preload( "res://components/card/Shell.tscn" )
		var instance = shell_scene.instantiate()
		instance.create_keys( debug_obj.shell.settings.play )
		self.add_child( instance )
	elif debug_obj.case == 2 :
		var scopa_scene = preload( "res://components/CardGame/Negotiation/ScopaState.tscn" )
		var instance = scopa_scene.instantiate()
		var draw_order = [
			"floor" , "floor" , "floor" , "floor" , 
			"player_hand" , "opponent_hand" , "player_hand" , "opponent_hand" , 
			"player_hand" , "opponent_hand" 
		]
		
		debug_obj.scopa.settings.stateless.deck = create_random_deck( scopa_dict.game.init_is_hidden_state )
		assert_arr_size( debug_obj.scopa.settings.stateless.deck , 1 , 40 , "global>debug_run>2>deck" )
		instance.read_cfg( debug_obj.scopa.settings.stateless )
		self.add_child( instance )
		instance.position_draw_pile()
		
		for target in draw_order :
			var args := {
				"source" : instance.local_cfg.deck ,
				"offset" : Vector2( 1 , 0 ) ,
				"duration" : 1.0
			}
			var overwrites := {}
			
			if target == "floor" :
				overwrites = {
					"target" : instance.local_cfg.board.floor ,
					"slice_start" : Vector2( 1.5 , 3 ) ,
				}
			elif target == "player_hand" :
				overwrites = {
					"target" : instance.local_cfg.player.hand ,
					"slice_start" : Vector2( 2 , 5.5 ) ,
				}
			elif target == "opponent_hand" :
				overwrites = {
					"target" : instance.local_cfg.opponent.hand ,
					"slice_start" : Vector2( 2 , 0.5 ) ,
				}
			
			args.merge( overwrites , true )
			
			instance.animate_deck_draw(
				args.source , args.target , args.slice_start , args.offset , args.duration 
			)
			
	elif debug_obj.case == 3 :
		var scopa_scene = preload( "res://components/CardGame/Negotiation/ScopaState.tscn" )
		var instance = scopa_scene.instantiate()
		debug_obj.scopa.settings.stateful.deck = process_piles(
			debug_obj.scopa.settings.stateful.deck , scopa_dict.game.init_is_hidden_state
		)
		debug_obj.scopa.settings.stateful.board.floor = Set.new().arr_to_set(
			process_piles( debug_obj.scopa.settings.stateful.board.floor , 
			scopa_dict.game.init_is_hidden_state )
		)
		debug_obj.scopa.settings.stateful.player.hand = Set.new().arr_to_set(
			process_piles( debug_obj.scopa.settings.stateful.player.hand ,
			scopa_dict.game.init_is_hidden_state )
		)
		debug_obj.scopa.settings.stateful.opponent.hand = Set.new().arr_to_set(
			process_piles( debug_obj.scopa.settings.stateful.opponent.hand , 
			scopa_dict.game.init_is_hidden_state )
		)
		
		assert_arr_size( debug_obj.scopa.settings.stateful.deck , 1 , 40 , 
		"global>debug_run>3>deck" )
		assert_int( debug_obj.scopa.settings.stateful.board.floor.size() , 1 , 10 ,
		"global>debug_run>3>floor" )
		assert_int( debug_obj.scopa.settings.stateful.player.hand.size() , 1 , 10 , 
		"global>debug_run>3>player_hand" )
		assert_int( debug_obj.scopa.settings.stateful.opponent.hand.size() , 1 , 10 , 
		"global>debug_run>3>opponent_hand" )
		
		instance.read_cfg( debug_obj.scopa.settings.stateful )
		self.add_child( instance )
		instance.position_piles()
		
		
func _ready() -> void:
	if debug_obj.enabled :
		debug_run()
		
		

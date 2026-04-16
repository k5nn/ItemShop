extends Node
class_name Global

const values = [ 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 ]
const negotiation_entities = {
	"suits" : {
		"Coins" : {
			"asset" : preload("res://assets/Card/Suits/Coins.png") ,
			"tooltip" : ""
		} ,
		"Clubs" : {
			"asset" : preload("res://assets/Card/Suits/Coins.png") ,
			"tooltip" : ""
		} ,
		"Cups" : {
			"asset" : preload("res://assets/Card/Suits/Coins.png") ,
			"tooltip" : ""
		} ,
		"Swords" : {
			"asset" : preload( "res://assets/Card/Suits/Swords.png" ) ,
			"tooltip" : ""
		}
	} ,
	"stickers" : {
		"R" : {
			"asset" : preload( "res://assets/Card/Suits/modifier.png" ) ,
			"effects" : "" ,
			"tooltip" : ""
		} ,
		"G" : {
			"asset" : preload( "res://assets/Card/Suits/modifier.png" ) ,
			"effects" : "" ,
			"tooltip" : ""
		} ,
		"B" : {
			"asset" : preload( "res://assets/Card/Suits/modifier.png" ) ,
			"effects" : "" ,
			"tooltip" : ""
		} ,
		"Y" : {
			"asset" : preload( "res://assets/Card/Suits/modifier.png" ) ,
			"effects" : "" ,
			"tooltip" : ""
		}
	} ,
	"actions" : {}
}

const negoation_actions = [ "Think" ]

var debug_obj = {
	"card" : {
		"config_output" : true ,
		"key_output" : false ,
		"validate_output" : true ,
	} ,
}

var suit_choice = negotiation_entities.suits.keys().pick_random()

var defaults = {
	"card" : {
		"quality" : {
			"bg" : preload("res://assets/Card/Suits/Base_Suit.png") ,
			"mode" : "Quality" ,
			"name" : suit_choice ,
			"value" : values.pick_random() ,
			"effects" : [] ,
			"to_serialize" : {
				"Clubs" : preload("res://assets/Card/Suits/Clubs.png") , 
				"Coins" : preload("res://assets/Card/Suits/Coins.png") , 
				"Cups" : preload("res://assets/Card/Suits/Cups.png") , 
				"Swords" : preload("res://assets/Card/Suits/Swords.png") ,
				"R" : preload( "res://assets/Card/Suits/modifier.png" ) ,
				"G" : preload( "res://assets/Card/Suits/modifier.png" ) ,
				"B" : preload( "res://assets/Card/Suits/modifier.png" ) ,
				"Y" : preload( "res://assets/Card/Suits/modifier.png" ) ,
			}
		} ,
		"action" : {
			"bg" : preload("res://assets/Card/Action/Base_Action.png") ,
			"mode" : "Action" ,
			"name" : "Strike" ,
			"effects" : [ "Enemy_damage" ] ,
			"to_serialize" : serialize_action_card( "Strike" , { "Enemy_damage" : 6 } )
		} ,
		"ret_dict" : {
			"layouts" : {
				"Quality" : preload( "res://components/card/layout_suit.tscn" ) ,
				"Action" : preload( "res://components/card/layout_action.tscn" ) ,
			} ,
		} ,
	} ,
	"scopa" : {
		"deck": [] ,
		"board": {
			"floor": []
		},
		"player": {
			"hand": [],
			"captured": [],
			"scopas": 0
		},
		"opponent": {
			"hand": [],
			"captured": [],
			"scopas": 0
		},
		"turn": "player",
		"last_capturer": null,
		"score": {
			"player": 0,
			"opponent": 0
		}
	}
}

func serialize_action_card( card_name : String , effects : Dictionary ) -> Dictionary :
	const asset_src = {
		"Strike" : preload( "res://assets/Card/Action/CardArt.png" ) ,
	}
	var to_serialize = {}
	
	to_serialize.set( "card_art" , asset_src[ card_name ] )
	
	for effect in effects :
		if effect == "HP_damage" : 
			to_serialize.set( effect , "Deal " + str( effects[ "HP_damage" ] ) + " damage" )
			
	return to_serialize

func build_data() -> Dictionary :
	if debug_obj.debug :
		if debug_obj.debug_case == 1 :
			return {}
	return {}

func get_system_data() -> Dictionary :
	if debug_obj.debug :
		if debug_obj.debug_case == 1 :
			return {}
	return {}

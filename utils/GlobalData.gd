extends Node
class_name Global

var debug_obj = {
	"debug" : true ,
	"debug_case" : 1
}

var defaults = {
	"card" : {
		"quality" : {
			"bg" : preload("res://assets/Card/Quality/Base_Quality.png") ,
			"mode" : "Quality" ,
			"name" : "Provenance" ,
			"base_value" : 10 ,
			"plus_multiplier" : 0 ,
			"effects" : {
				"R" : true
			} ,
			"to_serialize" : {
				"Provenance" : preload("res://assets/Card/Quality/Provenance.png") , 
				"Utility" : preload("res://assets/Card/Quality/Utility.png") , 
				"Durability" : preload("res://assets/Card/Quality/Durability.png") , 
				"Craftsmanship" : preload("res://assets/Card/Quality/Craftsmanship.png") ,
				"R" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"G" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"B" : preload( "res://assets/Card/Quality/modifier.png" ) ,
				"Y" : preload( "res://assets/Card/Quality/modifier.png" ) ,
			}
		} ,
		"battle" : {
			"bg" : preload("res://assets/Card/Battle/Base_Battle.png") ,
			"mode" : "Battle" ,
			"name" : "Strike" ,
			"effects" : { 
				"HP_damage" : 6 
			} ,
			"to_serialize" : serialize_battle_card_data( "Strike" , { "HP_damage" : 6 } )
		} ,
		"ret_dict" : {
			"layouts" : {
				"Quality" : preload( "res://components/card/layout_quality.tscn" ) ,
				"Battle" : preload( "res://components/card/layout_battle.tscn" ) ,
			} ,
		} ,
	} ,
}

func serialize_battle_card_data( card_name : String , effects : Dictionary ) -> Dictionary :
	const asset_src = {
		"Strike" : preload( "res://assets/Card/Battle/CardArt.png" ) ,
	}
	var to_serialize = {}
	
	to_serialize.set( card_name , asset_src[ card_name ] )
	
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

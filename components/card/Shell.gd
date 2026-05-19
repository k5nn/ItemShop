extends Control
class_name CardShell

const card_scenes = {
	"playing" : preload( "res://components/card/playingcard.tscn" )
}
const suit_dict = {
	"Coin" : preload( "res://assets/Card/Suits/Icons/coins.png" ) ,
	"Sword" : preload( "res://assets/Card/Suits/Icons/sword.png" ) ,
	"Cup" : preload( "res://assets/Card/Suits/Icons/cups.png" ) ,
	"Wand" : preload( "res://assets/Card/Suits/Icons/wand.png" )
}
const rank_dict = {
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
}
const art_dict = {
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
}

var local_cfg := {}

#create
func create_default_cfg( mode ) -> Dictionary :
	if mode == "play" :
		return {
			"mode" : "playing" ,
			"suit" : "Coin" ,
			"rank" : 8 ,
			"skin" : "Default"
		}
	else :
		return {}
#create

#event
func _on_mouse_entered() -> void:
	if self.get_parent() is Window :
		print( "Entered" )
		
func _on_mouse_exited() -> void:
	if self.get_parent() is Window :
		print( "Exited" )
	pass # Replace with function body.
#events

func _ready() -> void:
	
	if self.get_parent() is Window :
		local_cfg = create_default_cfg( "play" )
		$Frame.texture = preload( "res://assets/Card/Default_Frame.png" )
		self.position = get_viewport_rect().size * 0.25
		
		var instance = card_scenes[ local_cfg.mode ].instantiate()
		instance.position = $Frame.texture.get_size() * 0.05
		
		if local_cfg.mode == "playing" :
			const req_keys = [ "suit" , "rank" , "skin" ]
			
			local_cfg.erase( "mode" )
			for key in req_keys :
				assert( local_cfg.has( key ) )
			self.add_child( instance )
			instance.update_art( art_dict[ local_cfg.skin ][ local_cfg.suit ][ local_cfg.rank - 1 ] )
			instance.update_rank( rank_dict[ str( local_cfg.rank ) ] )
			instance.update_suit( suit_dict[ local_cfg.suit ] )
			instance.update_position( $Frame , -0.025 , 0.85 )

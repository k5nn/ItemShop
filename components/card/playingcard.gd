extends Control
class_name PlayingCard

var local_cfg := {}

#create
func create_default_cfg() -> Dictionary:
	return {
		"suit" : "Coin" ,
		"rank" : 8 ,
		"skin" : ""
	}
	
func create_keys( import_cfg ) :
	for key in import_cfg.keys() :
		local_cfg.set( key , import_cfg[ key ] )
#create

#update
func update_art( res : CompressedTexture2D ) :
	$Art.texture = res

func update_rank( res : CompressedTexture2D ) :
	$TopLeft/Rank.texture = res
	$BottomRight/Rank.texture = res

func update_suit( res : CompressedTexture2D ) :
	$TopLeft/Suit.texture = res
	$BottomRight/Suit.texture = res

func update_position( node : TextureRect , top : float , bottom : float ) :
	$TopLeft.position = node.texture.get_size() * top
	$BottomRight.position = node.texture.get_size() * bottom
#update

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	if self.get_parent() is Window :
		self.position = get_viewport_rect().size * 0.25
		local_cfg = create_default_cfg()
		update_art( preload("res://assets/Card/Suits/Art/Coin.png") )
		update_rank( preload( "res://assets/Card/Suits/Ranks/RED_8.png" ) )
		update_suit( preload( "res://assets/Card/Suits/Icons/coins.png" ) )
		update_position( $Art , 0.05 , 0.85 )
		
	$TopLeft.scale = Vector2( 0.05 , 0.05 )
	$BottomRight.scale = Vector2( 0.05 , 0.05 )
	
	
	

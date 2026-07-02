extends Control
class_name PlayingCard

var local_cfg := {}
var global = Global.new()
const req_keys = [ "art" , "rank" , "suit" ]

#create
func create_default_cfg() -> Dictionary:
	return global.defaults.playingcard

func create_keys( import_cfg : Dictionary ) :
	
	for key in req_keys :
		assert( import_cfg.has( key ) , str( import_cfg ) )
	
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

func update_displayed() :
	$TopLeft.visible = !$TopLeft.visible
	$BottomRight.visible = !$BottomRight.visible
#update

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent() is Window :
		self.position = get_viewport_rect().size * 0.25
		local_cfg = create_default_cfg()
	
	if global.debug_obj.playingcard.ready :
		print( local_cfg )
	
	update_art( local_cfg.art )
	update_rank( local_cfg.rank )
	update_suit( local_cfg.suit )
	
	if self.get_parent() is Window :
		update_position( $Art , 0.05 , 0.85 )
			
	$TopLeft.scale = Vector2( 0.05 , 0.05 )
	$BottomRight.scale = Vector2( 0.05 , 0.05 )

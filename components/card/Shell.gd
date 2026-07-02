extends Control
class_name CardShell

var global = Global.new()
var card_scenes = {
	"playing" : global.playing_dict.scene
}
var suit_dict = global.playing_dict.suit
var rank_dict = global.playing_dict.rank
var art_dict = global.playing_dict.art.front
var hidden_dict = global.playing_dict.art.back
var local_cfg := {}
var active_tweens := {}

const playing_keys = [ "suit" , "rank" , "front" , "back" , "is_hidden" ,"drag_enabled" ]

#create
func create_default_cfg( mode ) -> Dictionary :
	if mode == "play" :
		return global.defaults.shell.play
	else :
		return {}

func create_keys( import_cfg ) :
	var mode_keys := []
	
	if global.debug_obj.shell.create_keys :
		print( import_cfg )
	
	assert( import_cfg.has( "mode" ) )
	
	if import_cfg.mode == "playing" :
		mode_keys = playing_keys
	
	for key in mode_keys :
		assert( import_cfg.has( key ) , import_cfg )
	
	for key in import_cfg.keys() :
		local_cfg.set( key , import_cfg[ key ] )
#create

#read
func resolve_art( instance , to_toggle : bool ) -> Dictionary :
	assert( instance is PlayingCard )
	var to_ret := {}
	
	if to_toggle :
		local_cfg.is_hidden = !local_cfg.is_hidden
		instance.update_displayed()
	
	if instance is PlayingCard :
		if local_cfg.is_hidden :
			to_ret.set( "art" , hidden_dict[ local_cfg.back ] )
			to_ret.set( "debug_res" , "hidden_art"  )
		else :
			to_ret.set( "art" , art_dict[ local_cfg.front ][ local_cfg.suit ][ local_cfg.rank - 1 ] )
			to_ret.set( "debug_res" , "reveal_art"  )
			
	return to_ret

func resolve_rank( instance , new_rank : int ) -> Dictionary :
	assert( instance is PlayingCard )
	var to_ret := {}
	
	if new_rank > global.scopa_dict.game.ranks.max() :
		new_rank = global.scopa_dict.game.ranks.min()
	
	if new_rank < global.scopa_dict.game.ranks.min() :
		new_rank = global.scopa_dict.game.ranks.max()
	
	local_cfg.rank = new_rank
	
	if instance is PlayingCard :
		to_ret.set( "rank" , rank_dict[ str( local_cfg.rank ) ] )
		
	return to_ret

func resolve_suit( instance , new_suit : String ) -> Dictionary :
	assert( instance is PlayingCard )
	assert( suit_dict.has( new_suit ) )
	var to_ret := {}
	
	local_cfg.suit = new_suit
	
	if instance is PlayingCard :
		to_ret.set( "suit" , suit_dict[ new_suit ] )
	
	return to_ret
#read

#update
func update_tooltip_text( txt : String ) :
	
	if global.debug_obj.shell.update_tooltip_text :
		print( txt )
	
	$PopupAnchor/RichTextLabel.text = txt
#update

#event
func _on_mouse_entered() -> void:
	
	if local_cfg.is_hidden :
		return
	
	$PopupAnchor.visible = !$PopupAnchor.visible
	
func _on_mouse_exited() -> void:
	
	if local_cfg.is_hidden :
		return
	
	$PopupAnchor.visible = !$PopupAnchor.visible

func _on_gui_input(event: InputEvent) -> void:
		
	if event is InputEventKey :
		if !global.debug_obj.shell.anim_debug :
			return
		
		if event.pressed :
			if event.keycode == 49 :
				animate_position( self.position + Vector2( 100 , 0 ) , 0.5 )
				return
			elif event.keycode == 50 :
				animate_flip( 0.5 , 0.01 , 1.0 , "change_face" , [ local_cfg.visual ] )
				return
			elif event.keycode == 51 :
				animate_flip( 0.5 , 0.01 , 1.0 , "change_rank" , [ local_cfg.visual , local_cfg.rank + 1 ] )
				return
			elif event.keycode == 52 :
				animate_flip( 0.5 , 0.01 , 1.0 , "change_rank" , [ local_cfg.visual , local_cfg.rank - 1 ] )
				return
			elif event.keycode == 53 :
				animate_flip( 0.5 , 0.01 , 1.0 , "change_suit" , [ local_cfg.visual , "Sword" ] )
				return
		return
	
	if local_cfg.is_hidden :
		return
	
	if event is InputEventMouseMotion :
		if !local_cfg.has( "held" ) :
			return
		
		if local_cfg.held && local_cfg.drag_enabled:
			
			if global.debug_obj.shell.event_out :
				print( "dragging" )
				print( event )
			
			$PopupAnchor.visible = false
			self.position += event.position - ($Frame.texture.get_size() * 0.5)
			return
		
	if event is InputEventMouseButton :
		
		if event.pressed :
			$PopupAnchor.visible = false
			
			if global.debug_obj.shell.event_out :
				print( "clicked" )
				print( event )
			
			if local_cfg.drag_enabled :
				local_cfg.set( "held" , true )
				self.position += event.position - ($Frame.texture.get_size() * 0.5)
				return
			
			return
		else :
			$PopupAnchor.visible = true
			
			if global.debug_obj.shell.event_out :
				print( "click_release" )
				print( event )
			
			if local_cfg.drag_enabled :
				local_cfg.erase( "held" )
				return
			
			return
#events

#animations
func change_face( instance ) :
	assert( instance is PlayingCard )
	instance.update_art( resolve_art( instance , true )[ "art" ] )

func change_rank( instance , new_rank : int ) :
	assert( instance is PlayingCard )
	instance.update_rank( resolve_rank( instance , new_rank )[ "rank" ] )
	instance.update_art( resolve_art( instance , false )[ "art" ] )
	
func change_suit( instance , new_suit : String ) :
	assert( instance is PlayingCard )
	instance.update_suit( resolve_suit( instance , new_suit )[ "suit" ] )
	instance.update_art( resolve_art( instance , false )[ "art" ] )
	
func animate_position(target_pos: Vector2, duration: float) -> Tween:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", target_pos, duration)
	return tween
	
func animate_flip( duration: float , 
	start_tween : float , end_tween : float , 
	fn_name : String , args:  Array
	) -> Tween:
	var tween = create_tween()
	var half_duraction = duration * 0.5
	var init_is_hidden = local_cfg.is_hidden
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale:x", start_tween , half_duraction)
	
	if fn_name == "change_face" :
		tween.tween_callback(func() : call_deferred( fn_name  , args[ 0 ] ) )
	elif fn_name == "change_rank" || fn_name == "change_suit" :
		if init_is_hidden :
			tween.tween_callback(func() : call_deferred( "change_face"  , args[ 0 ] ) )
		tween.tween_callback(func() : call_deferred( fn_name  , args[ 0 ] , args[ 1 ] ) )
	
	tween.tween_property(self, "scale:x", end_tween , half_duraction)
	
	if fn_name != "change_face" and init_is_hidden :
		tween.tween_property(self, "scale:x", start_tween , half_duraction)
		tween.tween_callback(func() : call_deferred( "change_face"  , args[ 0 ] ) )
		tween.tween_property(self, "scale:x", end_tween , half_duraction)
	
	return tween
#animations

func _ready() -> void:
	if self.get_parent() is Window :
		local_cfg.merge( create_default_cfg( "play" ) , true ) 
		self.position = get_viewport_rect().size * 0.25
		self.focus_mode = Control.FOCUS_ALL
		self.grab_focus()
		
	var instance = card_scenes[ local_cfg.mode ].instantiate()
	$Frame.texture = preload( "res://assets/Card/Default_Frame.png" )
	instance.position = $Frame.texture.get_size() * 0.05
	
	assert( local_cfg.has( "mode" ) , str( local_cfg ) )
	
	if global.debug_obj.shell.anim_debug :
		self.focus_mode = Control.FOCUS_ALL
		self.grab_focus()
	
	if global.debug_obj.shell.ready :
		print( local_cfg )
		
	if local_cfg.mode == "playing" :
		const req_keys = playing_keys
		var to_pass = {
			"rank" : rank_dict[ str( local_cfg.rank ) ] ,
			"suit" : suit_dict[ local_cfg.suit ] ,
		}
		local_cfg.erase( "mode" )
		for key in req_keys :
			assert( local_cfg.has( key ) , str( local_cfg ) )
			
		to_pass.merge( resolve_art( instance , false ) )
			
		instance.create_keys( to_pass )
		instance.update_position( $Frame , -0.025 , 0.85 )
		
		$PopupAnchor.position.y = $Frame.position.y - 50
		update_tooltip_text( str( local_cfg.rank ) + " of " + local_cfg.suit )
		
		local_cfg.set( "visual" , instance )
		
		if local_cfg.is_hidden :
			local_cfg.visual.update_displayed()
		
		self.add_child( instance )
			
	$PopupAnchor/RichTextLabel.custom_minimum_size = Vector2( $Frame.texture.get_size().x , 100 )
	

extends RefCounted
class_name Set

var _dict: Dictionary = {}

#create
func add(value) -> void:
	_dict[value] = true
#create

#read
func has(value) -> bool:
	return _dict.has(value)
	
func values() -> Array:
	return _dict.keys()
	
func size() -> int:
	return _dict.size()
	
func is_empty() -> bool:
	return _dict.is_empty()

func full_join( a : Set , b : Set ) -> Set:
	var ret_set := Set.new()
	for entry in a.values() :
		ret_set.add( entry )
	for entry in b.values() :
		ret_set.add( entry )
	return ret_set
#read

#update
#update

#delete
func remove(value) -> void:
	_dict.erase(value)
	
func clear() -> void:
	_dict.clear()
#delete

#procedures / set utilities
func map(data_set: Set, func_ref: Callable) -> Set:
	var result := Set.new()
	for entry in data_set.values():
		result.add(func_ref.call(entry))
	return result

func filter(data_set: Set, predicate: Callable) -> Set:
	var result := Set.new()
	for entry in data_set.values():
		if predicate.call(entry):
			result.add(entry)
	return result

func arr_to_set(input: Array) -> Set:
	var result := Set.new()
	
	if input.is_empty() :
		return result
	
	for item in input :
		result.add( item )
	
	return result

func set_to_arrdict(input: Set , target_dict : Dictionary) -> Array:
	var result := []
	for item in input.values() :
		result.append( item[ target_dict ] )
	return result
#procedures / set utilities

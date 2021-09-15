extends Node2D

onready var tilemap := $TileMap
export var width := 320
export var height := 151

var osn := OpenSimplexNoise.new()

var isInit := false

func _ready() -> void:
	init()
	
	pass

func init(inSeed = '', seedHash = ''):
	isInit = false
	
	randomize()
	
	if inSeed:
		seedHash = hash(inSeed)
		osn.seed = seedHash
	else: if seedHash:
		inSeed = ""
		osn.seed = int(seedHash)
	else:
		seedHash = randi()
		osn.seed = seedHash
	
	print('')
	print('Seed '+ str(inSeed))
	print('Hash '+ str(seedHash))
	print('')
	
	get_node("Seed").set_text(str(inSeed))
	get_node("Hash").set_text(str(seedHash))
	
	generate_map()
	
	isInit = true
	
	pass

func clear_map() -> void:
	for x in width:
		for y in height:
				tilemap.set_cell(x,y, -1)

func generate_map() -> void:
	clear_map()
	
	for x in width:
		for y in height:
			var rand := floor((abs(osn.get_noise_2d(x,y)))*15)
			tilemap.set_cell(x,y, rand)
			
	print('')
	print('Period: ',osn.period)
	print('Octaves: ',osn.octaves)
	print('Persistence: ',osn.persistence)
	print('Lacunarity: ',osn.lacunarity)
	print('')
	
	get_node("PeriodLabel").set_text('Period '+ str(osn.period))
	get_node("OctaveLabel").set_text('Octave '+ str(osn.octaves))
	get_node("PersistanceLabel").set_text('Persistance '+ str(osn.persistence))
	get_node("LacunarityLabel").set_text('Lacunarity '+ str(osn.lacunarity))
	
	pass


func _on_period_slider_value_changed(value: float) -> void:
	osn.period = value
	generate_map()


func _on_octave_slider_value_changed(value: float) -> void:
	osn.octaves = value
	generate_map()


func _on_persist_slider_value_changed(value: float) -> void:
	osn.persistence = value
	generate_map()


func _on_lacun_slider_value_changed(value: float) -> void:
	osn.lacunarity = value
	generate_map()


func _on_Seed_text_changed():
	if isInit:
		init(get_node("Seed").get_line(0), '')
	pass 

func _on_Hash_text_changed():
	if isInit:
		init('', get_node("Hash").get_line(0))
	pass 

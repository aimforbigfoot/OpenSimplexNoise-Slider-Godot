extends Node2D

export var width := 128
export var height := 75
onready var tilemap := $TileMap
var openSimplexNoise := OpenSimplexNoise.new()


func _ready() -> void:
	randomize()
	openSimplexNoise.seed = randi()
	openSimplexNoise.octaves = 5
	generate_map()

func generate_map() -> void:
	for x in width:
		for y in height:
			var rand := floor((abs(openSimplexNoise.get_noise_2d(x,y)))*7)
			tilemap.set_cell(x,y, rand)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_end"):
		get_tree().reload_current_scene()

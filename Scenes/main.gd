extends Node2D

const PlatformScene = preload("res://Scenes/Platform.tscn")

@export var spawn_buffer_y := 300
@export var min_gap := 150
@export var max_gap := 250

var platforms : Array[StaticBody2D] = []
var next_spawn_y : float

@onready var cam    : Camera2D         = $Player/Camera2D
@onready var player : CharacterBody2D  = $Player

func _ready() -> void:
	randomize()
	next_spawn_y = player.global_position.y
	# pierwsza platforma dokładnie tam, gdzie stoi gracz
	_spawn_platform(next_spawn_y)
	
	# kilka kolejnych poniżej
	#for i in 5:
		#next_spawn_y -= randi_range(min_gap, max_gap)
		#_spawn_platform(next_spawn_y)
#
#func _process(_delta):
	#_test()

#func _process(_delta: float) -> void:
	#var py = player.global_position.y
#
	## dorzucaj nowe tak długo, aż są w buforze nad graczem
	#while next_spawn_y > py - spawn_buffer_y:
		#next_spawn_y -= randi_range(min_gap, max_gap)
		#_spawn_platform(next_spawn_y)
#
	## usuwaj te, co wypadły poniżej ekranu
	#for p in platforms.duplicate():
		#if p.global_position.y > py + spawn_buffer_y:
			#platforms.erase(p)
			#p.queue_free()

func _test():
	var screen_px = get_viewport().get_visible_rect().size
	#print(screen_px / get_viewport()\);
	## 2) oblicz połowę szerokości widoku w jednostkach świata, uwzględniając zoom
	#var half_w = screen_px.x * cam.zoom.x * 0.5
	## 3) wyznacz granice X
	#var left  = cam.global_position.x - half_w
	#var right = cam.global_position.x + half_w
	## 4) losuj X w tych granicach
	#var x_pos = randf_range(left, right)

	# 5) instancjuj platformę i ustaw pozycję
	var p = PlatformScene.instantiate()
	p.global_position = Vector2(1152, 648)
	add_child(p)
	platforms.append(p)
	
	print(p.get_viewport_rect().size.x)

func _spawn_platform(y_pos: float) -> void:
	# 1) pobierz rozmiar widocznego ekranu w pikselach
	var screen_px = get_viewport().get_visible_rect().size
	print(screen_px);
	# 2) oblicz połowę szerokości widoku w jednostkach świata, uwzględniając zoom
	var half_w = screen_px.x * cam.zoom.x * 0.5
	# 3) wyznacz granice X
	var left  = cam.global_position.x - half_w
	var right = cam.global_position.x + half_w
	# 4) losuj X w tych granicach
	var x_pos = randf_range(left, right)

	# 5) instancjuj platformę i ustaw pozycję
	var p = PlatformScene.instantiate()
	p.global_position = Vector2(x_pos, y_pos)
	add_child(p)
	platforms.append(p)

extends RayCast2D

var is_casting := false setget set_is_casting
var cast_point := cast_to 

signal propel_player(point)
signal stop_propel_player
signal use_fuel

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and get_tree().get_current_scene().get_node("Player").energy > 0:
		self.is_casting = event.pressed
		

func _physics_process(delta):
	force_raycast_update()
	
	$CollisionParticles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point()) #sets to cast point to the where the lazer hits the ground
		$CollisionParticles.global_rotation = get_collision_normal().angle()
		$CollisionParticles.position = cast_point
		
	if is_casting:
		emit_signal('use_fuel')
		
		
	$Line2D.points[1] = cast_point
	$BeamParticles.position = cast_point * 0.5
	$BeamParticles.emission_rect_extents.x = cast_point.length() * 0.5
	
func set_is_casting(cast: bool):
	is_casting = cast
	
	$BeamParticles.emitting = is_casting
	$CastingParticles.emitting = is_casting
	if is_casting:
		
		$Line2D.visible = true
		$LazerSound.play()
		appear()
		emit_signal("propel_player", cast_point)
		
	else:
		emit_signal("stop_propel_player")
		$LazerSound.stop()
		$CollisionParticles.emitting = false
		disappear()
	set_physics_process(is_casting)
	
func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10, 0.2)
	$Tween.start()

func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10, 0, 0.1)
	$Tween.start()
	
	

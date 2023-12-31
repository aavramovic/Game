extends CharacterBody2D


@export var move_Speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)
# parameters/Idel/blend_position
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var health_component: HealthComponent = $HealthComponent as HealthComponent




func _ready():
	update_animation_parameters(starting_direction)
	#health_component.connect("HealthChangedEventHandler", self, "_on_health_changed")
	#health_component.connect("DeathEventHandler", self, "_on_death")

func _physics_process(_delta): # time since last physics process updated
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	# Update velocity
	
	velocity  = input_direction * move_Speed
	
	#Move and slide 
	move_and_slide()
	
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)


func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

extends Node

class_name HealthComponent

var CurrentHealth: float
var Alive: bool = true as bool
var MaxHealth: float

# Define signals for event handlers
signal DeathEventHandler
signal HealthChangedEventHandler

func _init(currentHealth: float, maxHealthValue: float):
	CurrentHealth = currentHealth
	MaxHealth = maxHealthValue


func removeHp(damageValue):
	var oldHealth = CurrentHealth
	CurrentHealth = CurrentHealth - damageValue

	# Emit HealthChanged event
	if oldHealth != CurrentHealth:
		emit_signal("HealthChangedEventHandler", CurrentHealth)

	if CurrentHealth <= 0:
		Alive = false
		# Emit Death event
		emit_signal("DeathEventHandler")

func addHp(healValue: int):
	var oldHealth = CurrentHealth
	CurrentHealth = CurrentHealth + healValue

	# Emit HealthChanged event
	if oldHealth != CurrentHealth:
		emit_signal("HealthChangedEventHandler", CurrentHealth)

	if CurrentHealth > MaxHealth:
		CurrentHealth = MaxHealth

class_name Upgrade

var title: String
var description: String
var price: int

enum { NEW_WEAPON, FIRE_RATE_UP }
var type: int

var weapon_path: NodePath

# new weapon vars
var weapon_scene: PackedScene

# fire rate up vars
var time_between_shots: float

func _get_title_for_type():
    match type:
        NEW_WEAPON: return "New Weapon"
        FIRE_RATE_UP: return "Fire Rate Up"

func init(i_type: int, i_description: String, i_price: int, i_weapon_path: NodePath) -> Upgrade:
    type = i_type
    title = _get_title_for_type()
    description = i_description
    price = i_price
    weapon_path = i_weapon_path
    return self

func set_new_weapon_vars(i_weapon_scene: PackedScene) -> Upgrade:
    weapon_scene = i_weapon_scene
    return self

func set_fire_rate_up_vars(i_time_between_shots: float) -> Upgrade:
    time_between_shots = i_time_between_shots
    return self

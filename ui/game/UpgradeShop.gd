extends Control

signal upgrade_purchased
signal wave_repeated

export(NodePath) var upgrade_manager_path: NodePath
onready var _upgrade_man: UpgradeManager = get_node(upgrade_manager_path)

onready var _wallet: Wallet = get_node("/root/Wallet")

const upgrade_button_scene = preload("res://ui/game/UpgradeButton.tscn")

func _on_Repeat_pressed():
    emit_signal("wave_repeated")

func _on_upgrade_chosen(upgrade: Upgrade):
    if not _wallet.try_remove_scrap(upgrade.price):
        return  # TODO: some sort of notification/sound effect?

    _upgrade_man.burn_upgrade(upgrade)
    emit_signal("upgrade_purchased", upgrade)

func show():
    for child in $UpgradeButtons.get_children():
        child.queue_free()

    var upgrades := _upgrade_man.get_next_upgrades(2)
    for upgrade in upgrades:
        var b: UpgradeButton = upgrade_button_scene.instance()
        b.apply_upgrade(upgrade, _wallet.get_balance())
        var err := _wallet.connect("scrap_changed", b, "check_scrap_adequacy")
        if err:
            push_error("failed to connect wallet scrap_changed signal: %s" % err)
            return
        err = b.connect("pressed", self, "_on_upgrade_chosen", [upgrade])
        if err:
            push_error("failed to connect button pressed signal: %s" % err)
            return
        $UpgradeButtons.add_child(b)

    visible = true

func hide():
    visible = false

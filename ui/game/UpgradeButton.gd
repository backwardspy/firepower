extends Button

class_name UpgradeButton

var _upgrade: Upgrade

func apply_upgrade(upgrade: Upgrade, wallet_balance: int):
    _upgrade = upgrade
    $Box/Title.text = upgrade.title
    $Box/Description.text = upgrade.description
    $Box/CostBox/Price.text = str(upgrade.price)
    check_scrap_adequacy(wallet_balance)

func check_scrap_adequacy(wallet_balance: int):
    var can_be_bought := wallet_balance >= _upgrade.price
    disabled = !can_be_bought
    $Box/CostBox/Price.modulate = Color.white if can_be_bought else Color.red

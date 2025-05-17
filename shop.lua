-- SHOP XD

local Shop = {}

local shopItems = {
  {
    name = "Potion",
    description = "Recovery 50 HP",
    price = 20
  },
  {
    name = "Magic Potion",
    description = "Recovery 30 MP",
    price = 30
  },
  {
    name = "Iron Sword",
    description = "+5 Damage",
    price = 100
  }
}

function Shop.enter(player)
  while true do
    print("\n=== Shop ===")
    print("[+] Gold: " .. player.gold)
    print("[0]. quit shop")

    for i, item in ipairs(shopItems) do
      print(string.format("%d. %s - %d gold (%s)", i, item.name, item.price, item.description))
    end

    io.write("> ")
    local choice = tonumber(io.read())

    if choice == 0 then
      break

    elseif choice and shopItems[choice] then
      local item = shopItems[choice]
      if player.gold >= item.price then
        player.gold = player.gold - item.price
        player.inventory:addItem(item.name)
        print("[+] You bought " .. item.name)
        require('achievement').unlock("FIRST_PURCHASE", "Purchase First Item!")

      else
        print("[!] Not enough gold!")
      end

    else
      print("[!] Invalid Choice")
    end
  end
end

return Shop

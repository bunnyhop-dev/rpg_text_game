-- SHOP XD

local Shop = {}

local shopItems = {
  {
    name = "Potion",
    description = "Recovery 50 HP",
    price = 20,
    type = "consumable"
  },
  {
    name = "Magic Potion",
    description = "Recovery 30 MP",
    price = 30,
    type = "consumable"
  },
  {
    name = "Iron Sword",
    description = "+10 Damage",
    price = 100,
    type = "weapon",
    damage = 10
  },
  {
    name = "Common Lucky Box",
    description = "Random common items",
    price = 50,
    type = "lucky_box",
    rarity = "common"
  },
  {
    name = "Legendary Lucky Box",
    description = "Random legendary items",
    price = 200,
    type = "lucky_box",
    rarity = "legendary"
  }
}

local commonBoxLoot = {
  { name = "Iron Sword", damage = 10, chance = 60, rank = "Uncommon", type = "weapon"},
  { name = "Leather Armor", defense = 2, chance = 50, rank = "Common", type = "armor"},
  { name = "Steel Sword", damage = 20, chance = 35, rank = "Rare", type = "weapon"},
  { name = "Health Potion", heal = 30, chance = 40, rank = "Rare", type = "consumable"}
}

local legendaryBoxLoot = {
  { name = "Mask of Guardian", damage = 10, chance = 0.99342, rank = "Rare", type = "weapon"},
  { name = "Ice Cloth Armor", defense = 15, chance = 0.98723, rank = "Rare", type = "armor"},
  { name = "Magic Orbs", damage = 20, chance = 0.7, rank = "Epic", type = "weapon"},
  { name = "Eyes of Dragon", damage = 40, chance = 0.132, rank = "Legend", type = "weapon"},
  { name = "Cruz Blade", damage = 60, chance = 0.1, rank = "Legend", type = "weapon"},
  { name = "Zues Protection", defense = 100, chance = 0.01, rank = "Exotic", type = "armor"},
  { name = "Titan Armor", defense = 50, chance = 0.12, rank = "Divine", type = "armor"},
  { name = "Fire Dragon Cloth Armor", damage = 50, defense = 60, chance = 0.01, rank = "Exotic", type = "armor"}
}

local function openLuckyBox(rarity)
  local lootTable = rarity == "common" and commonBoxLoot or legendaryBoxLoot
  local totalChance = 0
  local roll = math.random() * 100
  
  for _, item in ipairs(lootTable) do
    totalChance = totalChance + item.chance
    if roll <= totalChance then
      return item
    end
  end
  return lootTable[1] -- Fallback to first item if something goes wrong
end

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
        
        if item.type == "lucky_box" then
          local loot = openLuckyBox(item.rarity)
          print("\n[+] Opening " .. item.name .. "...")
          print("[+] You got: " .. loot.name .. " (" .. loot.rank .. ")")
          player.inventory:addItem(loot)
        else
          player.inventory:addItem(item)
          print("[+] You bought " .. item.name)
        end
        
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

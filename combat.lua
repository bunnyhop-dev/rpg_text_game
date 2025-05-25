math.randomseed(os.time())
-- Combat system

local function randomString(length)
  local str = ''
  while true do
    for i = 1, length do
      local randomNum = math.random(1, 3)
      if randomNum == 1 then
        str = str .. string.char(math.random(97, 122))

      elseif randomNum == 2 then
        str = str .. string.char(math.random(65, 90))

      else
        str = str .. string.char(math.random(48, 57))
      end
    end
    return str
  end
end

local Combat = {}
local Achievement = require('achievement')

local enemyLoot = {
  { name = "Wooden Sword", damage = 5, rank = "Common", chance = 60, type = "weapon"},
  { name = "Cloth Armor", defense = 2, rank = "Common", chance = 50, type = "armor"},
  { name = "Health Potion", heal = 30, rank = "Rare", chance = 40, type = "consumable"},
  { name = "Warrior Orbs", damage = 7, defense = 5, rank = "Rare", chance = 30, type = "weapon"},
  { name = "Gold x2", rank = "Epic", chance = 5, type = "buff"},
  { name = "EXP x2", rank = "Epic", chance = 5, type = "buff"}
}

local function generateEnemy(playerLevel)
  local levelFactor = math.max(1, playerLevel * 0.5)
  return {
    name = randomString(10),
    exp = math.floor(math.random(10, 20) * levelFactor),
    health = math.floor(math.random(10, 30) * levelFactor),
    maxHealth = math.floor(math.random(10, 15) * levelFactor),
    damage = math.floor(math.random(2, 6) * levelFactor),
    defense = math.floor(math.random(2, 5) * levelFactor),
    gold = math.floor(math.random(9, 18) * levelFactor),
  }
end

local function rollForLoot()
  local roll = math.random() * 100
  local totalChance = 0
  
  for _, item in ipairs(enemyLoot) do
    totalChance = totalChance + item.chance
    if roll <= totalChance then
      return item
    end
  end
  return nil
end

-- Kombat MENU!!!
local function showCombatMenu()
  print("\n=== MENU ===")
  print('[1] Attack')
  print('[2] Use Skills')
  print('[3] Use Items')
  print('[4] Run away')
  io.write("> ")
  return io.read()
end

-- Battle begins
function Combat.startBattle(player)
  local monsters = {
    generateEnemy(player.level),
    generateEnemy(player.level),
    generateEnemy(player.level),
    generateEnemy(player.level),
    generateEnemy(player.level)
  }
  local monster = monsters[math.random(#monsters)]
  local monsterHP = monster.health

  print("[!] A wild monster " .. monster.name .. " appears!")

  while monsterHP > 0 do
    print("\n" .. monster.name .. " HP: " .. monsterHP)
    print(player.name .. " HP: " .. player.health)

    local choice = showCombatMenu()

    if choice == "1" then
      local baseDamage = player.strength
      local weaponDamage = player.equipment.weapon and player.equipment.weapon.damage or 0
      local totalDamage = math.max(1, (baseDamage + weaponDamage) - monster.defense / 2)
      monsterHP = monsterHP - totalDamage
      print("[+] You attacked " .. monster.name .. " for " .. totalDamage .. " damage!")
      if weaponDamage > 0 then
        print("   (Base: " .. baseDamage .. " + Weapon: " .. weaponDamage .. ")")
      end

    elseif choice == "2" then
      --Skill Coming soon
      print("[!] Not have any skills yet.")

    elseif choice == "3" then
      player.inventory:show()
      print("Select items you want to use (0 for cancel):")
      local itemChoice = tonumber(io.read())
      if itemChoice and itemChoice > 0 then
        player.inventory:useItem(itemChoice, player)
      end

    elseif choice == "4" then
      if math.random() < 0.5 then
        print("[+] You ran away from " .. monster.name .. "!")
        return

      else
        print("[!] You cannot escape from this battle!")
      end
    end

    --Monster turn
    if monsterHP > 0 then
      local damage_taken = math.max(1, monster.damage - player.defense / 2)
      player.health = player.health - damage_taken
      print(monster.name .. " attacked you for " .. damage_taken .. " damage!")

      if player.health <= 0 then
        print("[!] You were defeated by " .. monster.name .. "!")
        print(monster.name .. ": GGWP BRO :P")
        player.gold = math.floor(player.gold / 2)
        player.health = math.max(1, math.floor(player.maxHealth * 0.1))
        return
      end
    end
  end

  print("[+] You defeated " .. monster.name .. "! Congratulations!")
  print(player.name .. ": GG BRO")
  
  -- Apply gold multiplier
  local goldGained = math.floor(monster.gold * player.buffs.goldMultiplier)
  player.gold = player.gold + goldGained
  print("[+] You gained: " .. goldGained .. " gold!")
  
  -- Add experience
  player:addExp(monster.exp)
  
  -- Roll for loot
  local loot = rollForLoot()
  if loot then
    print("[+] Monster dropped: " .. loot.name)
    if loot.type == "buff" then
      if loot.name == "Gold x2" then
        player:addBuff("gold", 2)
      elseif loot.name == "EXP x2" then
        player:addBuff("exp", 2)
      end
    else
      player.inventory:addItem(loot)
    end
  end

  Achievement.unlock("FIRST_VICTORY", "First battle win!")
end

return Combat

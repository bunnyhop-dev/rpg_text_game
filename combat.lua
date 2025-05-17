math.randomseed(os.time())
-- Combat system

local Combat = {}
local Achievement = require('achievement')

local monsters = {
  {
    name = "Slime",
    health = math.random(10, 30),
    damage = math.random(2, 6),
    exp = math.random(10, 20),
    gold = math.random(1, 10)
  },
  {
    name = "Zombie",
    health = math.random(20, 50),
    damage = math.random(4, 8),
    exp = math.random(21, 36),
    gold = math.random(5, 15)
  },
  {
    name = "Dragon",
    health = math.random(100, 200),
    damage = math.random(10, 25),
    exp = math.random(90, 150),
    gold = math.random(50, 100)
  }
}

-- Random monsters
local function getRandomMonster()
  return monsters[math.random(#monsters)]
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
  local monster = getRandomMonster()
  local monsterHP = monster.health

  print("[!] A wild monster " .. monster.name .. " appears!")

  while monsterHP > 0 do
    print("\n" .. monster.name .. " HP: " .. monsterHP)
    print(player.name .. " HP: " .. player.health)

    local choice = showCombatMenu()

    if choice == "1" then
      local damage = player.strength
      monsterHP = monsterHP - damage
      print("[+] You attacked " .. monster.name .. " for " .. damage .. " damage!")

    elseif choice == "2" then
      --Skill Coming soon
      print("[!] Not have any skills yet.")

    elseif choice == "3" then
      player.inventory:show()
      print("Select items you want to use (0 for cancel):")
      local itemChoice = tonumber(io.read())
      if itemChoice and itemChoice > 0 then
        -- logic here :P
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
      player.health = player.health - monster.damage
      print(monster.name .. " attacked you for " .. monster.damage)

      if player.health <= 0 then
        print("[!] You were defeated by " .. monster.name .. "!")
        print(monster.name .. ": GGWP BRO :P")
        player.health = player.maxHealth / 2
        return
      end
    end
  end

  print("[+] You defeated " .. monster.name .. "! Congratulations!")
  print(player.name .. ": GG BRO")
  player:addExp(monster.exp)
  player.gold = player.gold + monster.gold
  print("[+] You gained: " .. monster.gold .. " gold!")

  Achievement.unlock("FIRST_VICTORY", "First battle win!")
end

return Combat

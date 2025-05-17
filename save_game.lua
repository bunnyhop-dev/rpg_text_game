local SaveGame = {}
local json = require('dkjson')

function SaveGame.saveGame(player)
  local saveData = {
    name = player.name,
    level = player.level,
    experience = player.experience,
    health = player.health,
    maxHealth = player.maxHealth,
    mana = player.mana,
    maxMana = player.maxMana,
    strength = player.strength,
    defense = player.defense,
    gold = player.gold,
    inventory = player.inventory.items
  }

  local file = io.open(player.name .. "_save.json", "w")
  if file then
    file:write(json.encode(saveData))
    file:close()
    return true
  end
  return false
end

function SaveGame.loadGame(playerName)
  local file = io.open(playerName .. "_save.json", "r")
  if file then
    local content = file:read("*all")
    file:close()
    local saveData = json.decode(content)

    local player = require('player').new(saveData.name)
    player.level = saveData.level
    player.experience = saveData.experience
    player.health = saveData.health
    player.maxHealth = saveData.maxHealth
    player.mana = saveData.mana
    player.maxMana = saveData.maxMana
    player.strength = saveData.strength
    player.defense = saveData.defense
    player.gold = saveData.gold

    for _, item in ipairs(saveData.inventory) do
      player.inventory:addItem(item)
    end
    return player
  end
  return nil
end

function SaveGame.hasSaveFile(playerName)
  local file = io.open(playerName .. "_save.json", "r")
  if file then
    file:close()
    return true
  end
  return false
end

return SaveGame

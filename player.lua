-- Player class

local Player = {}

function Player.new(name)
  return {
    name = name,
    level = 1,
    experience = 0,
    expToNextLevel = 100,
    health = 100,
    maxHealth = 100,
    mana = 50,
    maxMana = 50,
    strength = 10,
    defense = 5,
    gold = 0,
    inventory = require('inventory').new(),
    equipment = {
      weapon = nil,
      armor = nil,
    },
    skills = {},

    -- Level up
    levelUp = function (self)
      self.level = self.level + 1
      self.maxHealth = self.maxHealth + 20
      self.health = self.maxHealth
      self.maxMana = self.maxMana + 10
      self.mana = self.maxMana
      self.strength = self.strength + 3
      self.defense = self.defense + 2
      self.expToNextLevel = self.expToNextLevel * 1.5
      print("[+] Level up! Current Level: " .. self.level .. "!")
      require('achievement').unlock('LEVEl_UP', 'First Level up!')
    end,

    -- Add experience
    addExp = function (self, exp)
      self.experience = self.experience + exp
      print("[+] You gained " .. exp .. " EXP")

      while self.experience >= self.expToNextLevel do
        self.experience = self.experience - self.expToNextLevel
        self:levelUp()
      end
    end,

    -- Show Status :P
    showStatus = function (self)
      print("\n=== Player Stats ===")
      print("Name: " .. self.name)
      print("Level: " .. self.level)
      print("HP: " .. self.health)
      print("MP: " .. self.mana)
      print("Damage: " .. self.strength)
      print("Defense: " .. self.defense)
      print("EXP: " .. self.experience)
      print("Gold: " .. self.gold)
    end
  }
end

return Player

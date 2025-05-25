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
    gold = 9999999,
    inventory = require('inventory').new(),
    equipment = {
      weapon = nil,
      armor = nil,
    },
    buffs = {
      goldMultiplier = 1,
      expMultiplier = 1
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
      require('achievement').unlock('LEVEL_UP', 'First Level up!')
    end,

    -- Add experience
    addExp = function (self, exp)
      exp = math.floor(exp * self.buffs.expMultiplier)
      self.experience = self.experience + exp
      print("[+] You gained " .. exp .. " EXP")

      while self.experience >= self.expToNextLevel do
        self.experience = self.experience - self.expToNextLevel
        self:levelUp()
      end
    end,

    -- Equip item
    equipItem = function(self, itemIndex)
      local item = self.inventory.items[itemIndex]
      if not item then
        print("[!] Item not found!")
        return false
      end

      if item.type == "weapon" then
        if self.equipment.weapon then
          print("\nComparing weapons:")
          print(string.format("Current: %s (Damage: %d)", self.equipment.weapon.name, self.equipment.weapon.damage))
          print(string.format("New: %s (Damage: %d)", item.name, item.damage))
          
          self.inventory:addItem(self.equipment.weapon)
          self.strength = self.strength - self.equipment.weapon.damage
          print("[*] Unequipped " .. self.equipment.weapon.name)
        end

        self.equipment.weapon = item
        self.strength = self.strength + item.damage
        self.inventory:removeItem(itemIndex)
        print("[+] Equipped " .. item.name .. "! Damage increased by " .. item.damage)
        return true

      elseif item.type == "armor" then
        if self.equipment.armor then
          print("\nComparing armor:")
          print(string.format("Current: %s (Defense: %d)", self.equipment.armor.name, self.equipment.armor.defense))
          print(string.format("New: %s (Defense: %d)", item.name, item.defense))
          
          self.inventory:addItem(self.equipment.armor)
          self.defense = self.defense - self.equipment.armor.defense
          print("[*] Unequipped " .. self.equipment.armor.name)
        end

        self.equipment.armor = item
        self.defense = self.defense + item.defense
        self.inventory:removeItem(itemIndex)
        print("[+] Equipped " .. item.name .. "! Defense increased by " .. item.defense)
        return true
      end

      print("[!] Cannot equip this item!")
      return false
    end,

    -- Add buff
    addBuff = function(self, buffType, multiplier)
      if buffType == "gold" then
        self.buffs.goldMultiplier = multiplier
        print("[+] Gold multiplier set to x" .. multiplier)
      elseif buffType == "exp" then
        self.buffs.expMultiplier = multiplier
        print("[+] EXP multiplier set to x" .. multiplier)
      end
    end,

    -- Show Status
    showStatus = function (self)
      print("\n=== Player Stats ===")
      print("Name: " .. self.name)
      print("Level: " .. self.level)
      print("HP: " .. self.health .. "/" .. self.maxHealth)
      print("MP: " .. self.mana .. "/" .. self.maxMana)
      print("Damage: " .. self.strength)
      print("Defense: " .. self.defense)
      print("EXP: " .. self.experience .. "/" .. self.expToNextLevel)
      print("Gold: " .. self.gold)
      
      if self.equipment.weapon then
        print("\nEquipped Weapon: " .. self.equipment.weapon.name)
      end
      if self.equipment.armor then
        print("Equipped Armor: " .. self.equipment.armor.name)
      end
      
      if self.buffs.goldMultiplier > 1 then
        print("\nActive Buffs:")
        print("Gold Multiplier: x" .. self.buffs.goldMultiplier)
      end
      if self.buffs.expMultiplier > 1 then
        print("EXP Multiplier: x" .. self.buffs.expMultiplier)
      end
    end,

    statShow = function(self)
      print(self.name .. " | Level: " .. self.level .. "(" .. math.floor(self.experience) .. "/" .. math.floor(self.expToNextLevel) .. ")")
    end
  }
end

return Player

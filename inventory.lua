local Inventory = {}

function Inventory.new()
  return {
    items = {},

    addItem = function(self, item)
      table.insert(self.items, item)
    end,

    removeItem = function(self, index)
      if self.items[index] then
        table.remove(self.items, index)
        return true
      end
      return false
    end,

    show = function(self)
      print("\n=== Inventory ===")
      if #self.items == 0 then
        print("[!] Inventory is empty")
        return
      end

      for i, item in ipairs(self.items) do
        local itemInfo = i .. ". " .. item.name
        if item.rank then
          itemInfo = itemInfo .. " (" .. item.rank .. ")"
        end
        if item.damage then
          itemInfo = itemInfo .. " [DMG: " .. item.damage .. "]"
        end
        if item.defense then
          itemInfo = itemInfo .. " [DEF: " .. item.defense .. "]"
        end
        if item.heal then
          itemInfo = itemInfo .. " [Heal: " .. item.heal .. "]"
        end
        print(itemInfo)
      end
    end,

    useItem = function(self, index, player)
      local item = self.items[index]
      if not item then
        print("[!] Item not found!")
        return false
      end

      if item.type == "consumable" then
        if item.heal then
          player.health = math.min(player.maxHealth, player.health + item.heal)
          print("[+] Healed for " .. item.heal .. " HP!")
        end
        table.remove(self.items, index)
        return true
      elseif item.type == "weapon" or item.type == "armor" then
        -- Handle equipment in player.lua
        return false
      end

      print("[!] Cannot use this item!")
      return false
    end
  }
end

return Inventory

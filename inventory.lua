local Inventory = {}

function Inventory.new()
  return {
    items = {},

    addItem = function(self, itemName)
      table.insert(self.items, itemName)
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
        print(i .. ". " .. item)
      end
    end
  }
end

return Inventory

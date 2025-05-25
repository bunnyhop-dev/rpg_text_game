local gameHelp = {} 

function gameHelp.showAll()
  print("\n========== Game Help ==========")
  print("Battle: Fight monsters to gain exp and gold")
  --print("Rest: Heal yourself for " .. REST_COST .. " gold")
  print("Explore: Find items, gold, or enemies")
  print("Shop: Buy items or try your luck with lucky box")
  print("Status: Check your stats and inventory")
  print("\nTips:")
  print("- Equip weapons and armor to increase your stats")
  print("- Use potions during battle to heal")
  print("- Run away from battle if your health is low")
  print("- Save gold for better equipment")
  --print("- Inventory limit: " .. player.inventory_limit .. " items")
  print("========== Good Luck :P ==========")
end

return gameHelp

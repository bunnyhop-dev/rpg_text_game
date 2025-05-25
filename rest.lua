local Rest = {}

function Rest.enter(player)
  while true do
    print("\n========== Welcome to safezone ==========\n")
    print("[1] Recovery HP")
    print("[2] Recovery Mana")
    print("[0] Exit")
    print("===========================================")
    io.write("> ")
    local choice = tonumber(io.read())

    if choice == 1 then
      if player.gold < 20 then
        print("[!] Cannot Access! (20 Gold require!!)")
        return true
      elseif player.health >= player.maxHealth then
        print("[!] Cannot Access! Your Health is full now!")
        return true
      else
        player.gold = player.gold - 20
        local heal_amount = math.floor(player.maxHealth - player.health)
        print("[+] The word is safe now :P (Recovered " .. math.floor(heal_amount) .. " HP!)")
        player.health = player.maxHealth
      end

    elseif choice == 2 then
      if player.gold < 20 then
        print("[!] Cannot Access! (20 Gold require)")
        return true
    elseif player.health >= player.maxHealth then
      print("[!] Cannot Access! Your Health is full now")
      return true
    else
      player.gold = player.gold - 20
      local heal_amount = math.floor(player.maxMana - player.mana)
      print("[+] Gotcha! :P (Recovered " .. math.floor(heal_amount) .. " MANA!)")
      player.mana = player.maxMana
    end

    else
      print("Invalid choie") 
      return false
    end
  end
end

return Rest

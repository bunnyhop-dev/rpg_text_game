local Achievement = {}

local achievements = {
  FIRST_VICTORY = {
    name = "Bravely Warrior",
    description = "First Battle Victory",
    unlocked = false
  },
  LEVEL_UP = {
    name = "Grow Up",
    description = "First Level up",
    unlocked = false
  },
  QUEST_COMPLETE = {
    name = "Adventure",
    description = "Complete First Quest",
    unlocked = false
  },
  FIRST_PURCHASE = {
    name = "Shopping Warrior :P",
    description = "First Item Purchase",
    unlocked = false
  }
}

function Achievement.unlock(id, description)
  if achievements[id] and not achievements[id].unlocked then
    achievements[id].unlocked = true
    print("\n[+] Achievement Unlocked: " .. achievements[id].name)
    print(description)
  end
end

function Achievement.showAll()
  print("\n=== Achievements ===")
  for id, ach in pairs(achievements) do
    local status = ach.unlocked and "✓" or "✗"
    print(string.format("%s %s - %s", status, ach.name, ach.description))
  end
end

return Achievement

-- Quest System
local Quest = {}

local quests = {
  {
    id = "SLAY_SLIMES",
    name = "Defeat slime",
    description = "defeat 5 slimes",
    target = 5,
    reward = {
      exp = 100,
      gold = 50,
      items = {"Potion"}
    },
    progress = 0,
    completed = false
  },
  {
    id = "COLLECT_HERBS",
    name = "Collect Herb",
    description = "collect 3 herbs",
    target = 3,
    reward = {
      exp = 150,
      gold = 75,
      items = {"Magic_Herbs"}
    },
    progress = 0,
    completed = false
  }
}

function Quest.showQuests(player)
  print("\n=== Your quests ===")
  for i, quest in ipairs(quests) do
    local status = quest.completed and "completed" or string.format("(%d/%d)", quest.progress, quest.target)
    print(string.format("%d. %s - %s %s", i, quest.name, quest.description, status))
  end
end

function Quest.updateProgress(questId, amount)
  for _, quest in ipairs(quests) do
    if quest.id == questId and not quest.completed then
      quest.progress = quest.progress + amount
      if quest.progress >= quest.target then
        quest.completed = true
        require('achievement').unlock("QUEST_COMPLETE", "Completed First Quest!")
        return true
      end
    end
  end
  return false
end

return Quest

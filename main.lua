-- Main
local Player = require('player')
local Help = require('gamehelp')
local Combat = require('combat')
local Rest = require('rest')
local Quest = require('quest')
local Shop = require('shop')
local Inventory = require('inventory')
local Achievement = require('achievement')
local SaveGame = require('save_game')

local gameState = {
  player = nil,
  isRunning = true
}

local function initGame()
  print("=== Welcome to Text RPG! ===")
  io.write("Enter your username: ")
  local name = io.read()
  if name == "" then
    name = "Warrior"
  end

  io.write('[1] New Game\n[2] Load Game\n> ')
  local choice = io.read()

  if choice == "2" and SaveGame.hasSaveFile(name) then
    gameState.player = SaveGame.loadGame(name)
    print("[+] Game loaded!")
    os.execute('sleep 1')
    os.execute('clear')

  else
    gameState.player = Player.new(name)
    print("[+] Create New Charactor")
  end
end

local function MainMenu()
  print("\n======================\n")
  print("[VERSION : BETA 1.1x0525]")
  print("[Type `help` for help!]")
  print("\n======================\n")
  print("[1] Player Stats")
  print("[2] Battle (monster)")
  print("[3] Rest")
  print("[4] Quest")
  print("[5] Shop")
  print("[6] Inventory")
  print("[7] Use Item")
  print("[8] Achievement")
  print("[9] Save Game")
  print("[0] Exit Game")
  gameState.player:statShow()
  io.write("> ")
  return io.read()
end

local function gameLoop()
  while gameState.isRunning do
    local choice = MainMenu()

    if choice == "help" then
      Help.showAll()
    end

    if choice == "1" then
      gameState.player:showStatus()

    elseif choice == "2" then
      Combat.startBattle(gameState.player)

    elseif choice == "3" then
      Rest.enter(gameState.player)

    elseif choice == "4" then
      Quest.showQuests(gameState.player)

    elseif choice == "5" then
      Shop.enter(gameState.player)

    elseif choice == "6" then
      gameState.player.inventory:show()

    elseif choice == "7" then
      gameState.player.inventory:show()
      print("Select item to use (0 for cancel):")
      local itemChoice = tonumber(io.read())
      if itemChoice and itemChoice > 0 then
        local item = gameState.player.inventory.items[itemChoice]
        if item then
          if item.type == "weapon" or item.type == "armor" then
            gameState.player:equipItem(itemChoice)
          else
            gameState.player.inventory:useItem(itemChoice, gameState.player)
          end
        else
          print("[!] Invalid item choice!")
        end
      end

    elseif choice == "8" then
      Achievement.showAll()

    elseif choice == "9" then
      SaveGame.saveGame(gameState.player)

    elseif choice == "0" then
      print("[!] Good bye, Warrior :P")
      gameState.isRunning = false
    end
  end
end

initGame()
gameLoop()

-- Main
local Player = require('player')
local Combat = require('combat')
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
  print("\n=== Main Menu ===")
  print("\nVersion: Beta\n=================")
  print("[1] Player Stats")
  print("[2] Battle (monster)")
  print("[3] Quest")
  print("[4] Shop")
  print("[5] Inventory")
  print("[6] Achievement")
  print("[7] Save Game")
  print("[0] Exit Game")
  io.write("> ")
  return io.read()
end

local function gameLoop()
  while gameState.isRunning do
    local choice = MainMenu()

    if choice == "1" then
      gameState.player:showStatus()

    elseif choice == "2" then
      Combat.startBattle(gameState.player)

    elseif choice == "3" then
      Quest.showQuests(gameState.player)

    elseif choice == "4" then
      Shop.enter(gameState.player)

    elseif choice == "5" then
      gameState.player.inventory:show()

    elseif choice == "6" then
      Achievement.showAll()

    elseif choice == "7" then
      SaveGame.saveGame(gameState.player)

    elseif choice == "0" then
      print("[!] Good bye, Warrior :P")
      gameState.isRunning = false
    end
  end
end

initGame()
gameLoop()

# Text-Based RPG Adventure Game

A feature-rich command-line RPG game built with Lua, featuring comprehensive RPG mechanics including combat, quests, inventory management, and achievements.

## 🎮 Features

### Character System
- Level progression system with experience points
- Character stats (HP, MP, Strength, Defense)
- Automatic stat increases upon level up

### Combat System
- Turn-based combat mechanics
- Multiple monster types with different difficulties
- Combat options:
  - Basic attacks
  - Skills (expandable)
  - Item usage
  - Escape option

### Quest System
- Multiple quest types
- Quest progress tracking
- Rewards upon completion
  - Experience points
  - Gold
  - Special items

### Shop System
- Buy various items:
  - Health potions
  - Magic potions
  - Equipment
- Gold currency system

### Inventory System
- Item management
- Equipment system
- Usable items

### Achievement System
- Multiple achievements to unlock
- Progress tracking
- Achievement notifications

### Save System
- Save game progress
- Load previous games
- JSON-based save files

## 🚀 Getting Started

### Prerequisites
- Lua 5.1 or higher
- JSON library for Lua

### Installation
1. Clone the repository
```bash
git clone https://github.com/bunnyhop-dev/rpg_text_game.git
cd rpg_text_game
```

2. Install the required JSON library
```bash
luarocks install dkjson
```

### Running the Game
```bash
lua main.lua
```

## 🛠️ Customization
You can customize the game by:
- Adding new monsters in `combat.lua`
- Creating new quests in `quest.lua`
- Adding items to the shop in `shop.lua`
- Creating new achievements in `achievement.lua`

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License
This project is licensed under the MIT License - see the LICENSE file for details.

## 📖 Credits
Created by [bunnyhop-dev](https://github.com/bunnyhop-dev)

## 🔄 Version History
- Beta
  - Initial release
  - Basic game mechanics
  - Combat system
  - Quest system
  - Achievement system

## 🚧 Planned Features
- [ ] Additional monster types
- [ ] More complex quest chains
- [ ] Extended skill system
- [ ] Character classes
- [ ] Equipment crafting system
- [ ] Multiple save slots
- [ ] Boss battles
- [ ] Trading system

## ❗ Known Issues
- None reported yet

## 📞 Support
For support, please open an issue in the repository or contact the maintainer.

## 🌟 Acknowledgments
- Thanks to the Lua community for their excellent documentation
- Inspired by classic text-based RPGs

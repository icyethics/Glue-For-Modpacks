# Glue For Modpacks V.0.0.2
 Balatro Mod to add utilities that may make playing with multiple content mods more enjoyable. Currently, the scope is small, but if other additions seem beneficial, those will be added too.
 - Change the # of slots of shop areas
 - Change the # of joker/consumable slots
 - Change the default spawn rate of jokers (useful if many mods add consumable types that their combined rates start to dwarf the joker rate)

# How To Use
Currently, the mod has no config UI. To adjust the chances, manually adjust the numbers in the config.lua

# Additional Info
By default the joker chances are set to be about 70% of the items spawning in the shop when you have no vouchers that increase any odds. At 70%, the chances of a shop containing a joker are 91% by default. 

If you want to not keep the chances of jokers spawning per shop slot, but the chances of jokers spawning per reroll, set it instead to one of the following chances, depending on how many item slots the shop will have by default:
- 3 slots: 0.56
- 4 slots: 0.45
- 5 slots: 0.38



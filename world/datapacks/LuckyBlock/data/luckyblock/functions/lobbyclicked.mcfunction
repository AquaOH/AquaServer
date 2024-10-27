gamemode adventure @a[tag=!admin,tag=!isStarted]
execute store result score _nearestInteraction_LuckyBlock timestamp run data get entity @e[type=minecraft:interaction,limit=1,tag=toLuckyBlock] interaction.timestamp
scoreboard players operation _timestampDifference_LuckyBlock timestamp = _nearestInteraction_LuckyBlock timestamp
scoreboard players operation _timestampDifference_LuckyBlock timestamp -= _lastInteraction_LuckyBlock timestamp
execute if score _timestampDifference_LuckyBlock timestamp matches 1.. run execute as @e[type=minecraft:interaction,limit=1,tag=toLuckyBlock] at @s on target run function luckyblock:tryjoinluckyblock
execute if score _timestampDifference_LuckyBlock timestamp matches 1.. run scoreboard players operation _lastInteraction_LuckyBlock timestamp = _nearestInteraction_LuckyBlock timestamp

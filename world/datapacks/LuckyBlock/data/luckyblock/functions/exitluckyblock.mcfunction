execute as @s in minecraft:overworld run tp @s 0 51 110
execute as @s run scoreboard players remove _inLuckyBlock playerAmounts 1
tellraw @s {"text":"You left LuckyBlock!","color":"red"}
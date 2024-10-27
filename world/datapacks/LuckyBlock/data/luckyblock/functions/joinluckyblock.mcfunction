tellraw @s {"text":"You joined LuckyBlock!","color":"green"}
execute as @s run scoreboard players add _inLuckyBlock playerAmounts 1
execute as @e[type=interaction,limit=1,tag=toLuckyBlock] in minecraft:123 on target run tp -25 -59 207
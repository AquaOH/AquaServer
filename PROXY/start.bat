@echo off

:start
java -Xmx2048M -Xms2048M -XX:+AlwaysPreTouch -XX:+ParallelRefProcEnabled -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:MaxInlineLevel=15 -jar velocity-3.3.0-SNAPSHOT-413.jar 

echo Server restarting...
echo Press CTRL + C to stop.
goto :start
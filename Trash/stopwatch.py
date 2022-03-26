from time import sleep 
import os
seconds = 1

if os.path.exists("Libraries\\stopwatch count.txt"):
    os.remove("Libraries\\stopwatch count.txt")

while True:
    with open("Libraries\\stopwatch count.txt", "a") as file:
        if (seconds < 60):
            file.write(str(seconds) + " sec\n")
            sleep(1)
            seconds += 1
        elif seconds >= 60 and seconds <3600:
            minutes = seconds // 60
            seconds_min = seconds % 60
            file.write(str(minutes) + " min, " + str(seconds_min) + " sec\n")
            sleep(1)
            seconds += 1
        elif seconds >= 3600 and seconds <= 86400:
            hours = seconds // 3600
            minutes_hour = (seconds % 3600) // 60
            seconds_hour = (seconds % 3600) % 60
            file.write(str(hours) + " hr, " + str(minutes_hour) + " min, " + str(seconds_hour) + " sec\n")
            sleep(1)
            seconds += 1

Setlocal
@ECHO off
CLS
TITLE Windows Hosts File Ad Blocker Setup
set desktop=C:%homepath%\desktop\

REM Using to Powershell to download adlists
ECHO.
ECHO Downloading Ad-List 1
powershell -Command "wget https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -outfile %desktop%1.txt"
ECHO Downloading Ad-List 2
powershell -Command "wget https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt -outfile %desktop%2.txt"
ECHO Downloading Ad-List 3
powershell -Command "wget https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt -outfile %desktop%3.txt"

REM Consolidate All 4 Adlists

ECHO Combining Ad-Lists
powershell -Command "Get-Content %desktop%1.txt, %desktop%2.txt, %desktop%3.txt | Set-Content %desktop%AdList.txt"

REM Creating a new basic hosts file

ECHO Adding Windows Required Hosts
ECHO 127.0.0.1 localhost > %desktop%hosts.txt
ECHO 127.0.0.1 localhost.localdomain >> %desktop%hosts.txt
ECHO 127.0.0.1 local >> %desktop%hosts.txt
ECHO 255.255.255.255 broadcasthost >> %desktop%hosts.txt
ECHO ::1 localhost >> %desktop%hosts.txt
ECHO ::1 ip6-localhost >> %desktop%hosts.txt
ECHO ::1 ip6-loopback >> %desktop%hosts.txt
ECHO fe80::1%%lo0 localhost >> %desktop%hosts.txt
ECHO ff00::0 ip6-localnet >> %desktop%hosts.txt
ECHO ff00::0 ip6-mcastprefix >> %desktop%hosts.txt
ECHO ff02::1 ip6-allnodes >> %desktop%hosts.txt
ECHO ff02::2 ip6-allrouters >> %desktop%hosts.txt
ECHO ff02::3 ip6-allhosts >> %desktop%hosts.txt
ECHO 0.0.0.0 0.0.0.0 >> %desktop%hosts.txt

REM Move non redirecting entries to the new hosts file

ECHO Copying Ad Blocking Entries to hosts file
find "0.0.0.0" %desktop%AdList.txt  |find "0.0.0.0" >> %desktop%hosts.txt

REM Removing duplicate lines

ECHO Removing Duplicate Entries
powershell -Command "gc %desktop%hosts.txt | get-unique >> %desktop%hosts"

REM Backing up and deleting the current hosts file

ECHO Backing up active hosts file
Copy C:\Windows\System32\drivers\etc\hosts %desktop%hosts_backup.txt

ECHO Deleting active hosts file
DEL C:\Windows\System32\drivers\etc\hosts

REM Moving the new hosts file

ECHO Moving new hosts file to be active
copy %desktop%hosts C:\Windows\System32\drivers\etc\hosts

REM Delete Temp Files

ECHO Deleting temp files
DEL %desktop%1.txt
DEL %desktop%2.txt
DEL %desktop%3.txt
DEL %desktop%hosts.txt
DEL %desktop%AdList.txt
DEL %desktop%hosts

ECHO.
ECHO Ad Blocking hosts file has been updated successfully.
ECHO.

Pause

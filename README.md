# Win10-Hosts-File-DNS-Ad-Blocker
## Creates and applies a Hosts file based ad blocker, written to be as "plain-english readable" as possible.


This was inspired by and uses the same block lists as Pi-Hole, I'd highly recommend building your own and donating to them if you can afford to.

https://pi-hole.net/  
https://github.com/pi-hole/pi-hole/#one-step-automated-install

The script could be a lot cleaner and more efficiently written, but I wanted to create something useful that even people with little to no scripting experience could read and understand easily and use as a starting point to creating scripts themselves. 

To run:
===

1. Right click and run "Ad_block.bat" as admin  
2. Wait until you see "Press any key to continue . . ."
3. Press any key (Spacebar or Enter will work if you don't have an any key)
4. Optional: You can check the hosts file at "C:\Windows\System32\drivers\etc\hosts" you should see a LOT of 0.0.0.0 (ad domain) entries
5. Done 

Needs to be run as admin to replace the current hosts file, your current hosts file will be saved to your desktop as "hosts_backup.txt".

If you want to restore the origional file rename it to "hosts" (no file extension) and move or copy it to C:\Windows\System32\drivers\etc\

I suggest moving it or renaming it after the first run or you will lose the stock one the next time you run this.

If lost or overwritten instructions to restore your origional hosts file can also be found here:  
https://support.microsoft.com/en-us/topic/how-to-reset-the-hosts-file-back-to-the-default-c2a43f9d-e176-c6f3-e4ef-3500277a6dae

~~*Ad-list 3 will currently throw errors because it doesn't exist, eventually I'll verify if it's permanantly gone and will remove it if so.*~~  
Changed my mind and just removed the origional Ad-list 3, the old Ad-list 4 is now Ad-list 3

To add adlists:
===
**Step 1:**
- Copy and add the lines that look like these:

```
ECHO Downloading Ad-List 4
powershell -Command "wget https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt -outfile %desktop%4.txt"
```

**Step 2:**

- Change the Ad-List #, URL, and "%desktop%#.txt" so it doesn't match other lines.  
- So the next on should look like this:
```
ECHO Downloading Ad-List 5
powershell -Command "wget NewURL.txt -outfile %desktop%5.txt"
```
**Step 3:**

- Add ", %desktop%#.txt" to the command that combines the lists after "%desktop%4.txt":  
```
powershell -Command "Get-Content %desktop%1.txt, %desktop%2.txt, %desktop%3.txt, %desktop%4.txt, %desktop%#.txt  | Set-Content %desktop%AdList.txt"
```

**Step 4:**

- Add the new txt file to the clean-up section.
```
DEL %desktop%1.txt
DEL %desktop%2.txt
DEL %desktop%3.txt
DEL %desktop%4.txt
DEL %desktop%#.txt
DEL %desktop%hosts.txt
DEL %desktop%AdList.txt
DEL %desktop%hosts

```

import commands

info = commands.getoutput("mocp --info").splitlines()

if info == ["State: STOP"]:
    print "--"
    exit()
# Artist Song Album
print info[3].replace('Artist:',''), info[4].replace('SongTitle:',''), info[5].replace('Album:','')

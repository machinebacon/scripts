import commands

info = commands.getoutput("mocp --info").splitlines()

if info == ["State: STOP"]:
    print "Music: Not playing"
    exit()

print info[4].replace('SongTitle','Title')
print info[3]
print info[5]
print "Time: ", info[9][13:], "/", info[6][11:]



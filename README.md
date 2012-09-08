Here you can find a collection of LUA scripts for Verlihub. To find more scripts search on http://ro.4242.hu/cgi-bin/yabb2/YaBB.pl (Hungarian forums) or ask Google

HubPoll.lua
----
This script allows OPs to post polls that users can vote on. Useful for gathering the general opinion of the hub.
When a user connects to the hub (if he hasen't already voted and he has a relvant class), he will be prompted that there is a poll available and he will see some general information about commands. 
Script has been set up so only the admin (creator) can delete the poll. None - except the admin - will be able to see the results until he have voted. 
The syntax of the command is fairly easy. For example:

	!poll add Which OS do you prefer?_Windows_Mac_Linux_Other_3

would create a poll for users with class greater than 3 about which OS they prefer. Users would then use the +poll view and +poll vote triggers to vote and view the poll. If the users have a lower class, they will be told that no poll exists.

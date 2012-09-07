-- Trivia bot port for Verlihub by bourne (bourne@freemail.hu) -- This bot originally was written by Don Leon for PtokaX with LUA version up to 4.0, thank you Leon.
-- Note: This is a modified version for the latest LUA (version 5.1)
-- Now it works in any game mode without limitations. Enjoy.

---------------[ Helper functions ]---------------


---------------[ Global variables ]---------------
BotName = "!-:-Eve"
BotName2 = "!-:-Eve"
BotName1 = "!-:-Adam"
BotName3 = "Hint"
--owner can reset points
owner1 = "OWK"
owner2 = "Andy"
ScriptVersion = "   (Leon changed By OWK)   "
res,numelehubului = VH:GetConfig("config","hub_name")
BotVersion = BotName.." "..ScriptVersion
-----!!!! IMPORTANT Setting !!!!-----
--hub folder--
--------------------------------------------------------------------------------
locdef1 = "/etc/verlihub" --  ( /etc/verlihub or /root/.verlihub or /home/.verlihub, etc )

-- folderul trivia, si scriptul trivia.lua vor fi copiate in interiorul folderului script specific hubului
--------------------------------------------------------------------------------
--rescrierea motd , motd1 fisierul unde trebuie sa fie motd

strTrivMotd1File = locdef1.."/motd1"
strTrivMotdFile = locdef1.."/motd"
-- This file is not needed it will be created if it not exists

locdef = locdef1.."/scripts"
numecale = locdef.."/trivia/" -- calea catre directorul in care va face fisierele
caledefault = locdef.."/trivia/"
calesiguranta1 = locdef.."/trivia/s_orara/" -- calea catre directorul unde va salva automat la fiecare ora
calesiguranta2 = locdef.."/trivia/s_zilnica/" -- calea catre directorul unde va salva automat in fiecare zi

strTrivIniTimeFile = numecale.."initime.dat"
strTrivIniMFile = numecale.."mini.dat"
strTrivHelpTxtFile = numecale.."helptxt.txt"
strTrivScoreFile = numecale.."triviascores.dat"
strTrivScoreEternFile = numecale.."triviascoresE.dat"
strTrivRunFile = numecale.."run.dat"
strTrivRunHourFile = numecale.."runhour.dat"
strTrivRunDayFile = numecale.."runday.dat"
strTrivRunWeekFile = numecale.."runweek.dat"
strTrivScoreHourFile = numecale.."triviahourscores.dat"
strTrivScoreDayFile = numecale.."triviadayscores.dat"
strTrivScoreWeekFile = numecale.."triviaweekscores.dat"
strTrivLukyFile = numecale.."luky.dat"
strTrivBviFile = numecale.."bvi.dat"
strTrivTeamNameFile = numecale.."teamsname.dat"
strTrivTeamScoreFile = numecale.."teamscores.dat"
strTrivStrikeFile = numecale.."strike.dat"
strteamFile = numecale.."teamFile.dat"
strTrivPremiiFile = numecale.."premiiFile.dat"
strTrivstareqFile = numecale.."stareQ.dat"
strTrivStatFile = numecale.."statFile.dat"
strTrivStatHFile = numecale.."statHFile.dat"
strTrivDuelFile = numecale.."duelstatFile.dat"
strTrivScorDuelFile = numecale.."duelscorFile.dat"
strTriModqFile = numecale.."modqFile.dat"
strTriqrefFile = numecale.."qrefFile.dat"
strTrinrqFile = numecale.."nrqrefFile.dat"
strTrivintrebariFile = numecale.."Intrebari/fisier.dat"
strTrivQDFile = numecale.."Data/intrebarizilnice.dat"

--newfisiere
strTrivMesaje = numecale.."Setting/mesaje.dat"
strTrivSetari = numecale.."Setting/setari.dat"
strTrivLogSet = numecale.."Setting/logset.dat"
strTrivLog = numecale.."Setting/logowcmd.dat"



--fisier cu intreabri reparate ( teoretic fara space inceput si sfarsit si fara diacritice )
strTrivreparatFile = numecale.."reparat.dat"

--nefolosite
strTrivWelcomeFile = numecale.."welcome.txt"
useredenFile = numecale.."usereden.txt"

-- This file is needed unless you want to run a Trivia with only three questions ;)
strDefTrivFile = numecale.."Questions/trivia"
strDefTrivSpeedFile = numecale.."triviaspeed.dat"
strDefTrivSpeed2File = numecale.."triviaspeed2.dat"
strTrivFile = strDefTrivFile
strQFile = "/home/thoth/trivia/questions.dat"
strTrivQuestion = numecale.."Questions/Question/question.dat"


-- This char will be the global separator? (Make it one that is not used in nicknames nor questions ;)
strGSep = "*"
strGSep1 = "#"
strGSep2 = "("
strGSep3 = "+++"

-- This char is used to mask the unrevealed chars
strCMask = "@"

-- Default startup mode of Trivia!

lngMode = 0

-- Max number of questions to show when a Operator ask to see list Questions 0 = 0, -1 = Disabled
lngMaxShowList = 5

-- Max no of Hints per word, and always hit on a hidden char
lngMaxHints = 4
boolHintAlwaysHitHidden = nil -- (nil = off, 1 = on)

-- How much time before a question end. Time in Trivia is measured in 15 seconds, 1 = 15 seconds, 2 = 30 seconds etc!
-- Rest is how long to rest after a question is solved depening on when the word is solved in the Timer loop it is �15 secs to the setting!
lngMaxTime = 32 -- (Needs to be a multiple of 4   i.e. 4 / 8 / 12 / 16)
lngRestTime = 1 -- This will cause to wait 15 secs between questions.
lngHintTime = 8 -- Gives a hint in 8 secs.

-- How often should the bot autosave the scores
boolAutoSaveScores = 1 -- (nil = off, 1 = on)
countSaveTurns = 10 -- After how many questions should the scores be saved

-- Should bot reveal the correct answer once time is up?
boolRevealAnswer = 1 -- (nil = off, 1 = on)

-- Should the bot display what guess made the word become a little clearer if played in PM!
boolShowGuessesInPM = 1 -- (nil = off, 1 = on)

-- Should the bot Auto Reveal Hints?
boolAutoHint = 1 -- (nil = off, 1 = on)

-- Should the bot auto login every user on connect ?
boolAutoLogin = nil -- (nil = off, 1 = on)

-- Do you want users to be able to add questions ? Operators can always add questions.
boolAddQuestion = 1 -- (nil = No, 1 = Yes)

--Do you want 
boolsmartQ = 1 -- alege intrebarile in asa fel incat sa se repete f rar si sa echilibreze dificulatea functie de setare
boolsalvarifisiere = 1

--incetineste curgerea triviei cand nu se joaca 1 ca incetinirea sa functioneze 0 ca ea sa curga tot asa inainte
boolautoincetinire = 1 
-- scrierea scorului zilnic la motd ( 1 daca doriti scrierea 0 pentru a nu interveni asupra motd )
boolautomotd = 1
-- mod de resetare - 0 daca resetarea statisticilor intrebarilor se face cand se reseteaza si topul etern - 1 daca resetarea se face o data cu resetarea topului lunar( statisticile intrebarilor reprezentand record si recordam pe intrebare precum si situatia ei daca a fost sau nu iesita deja)
modreset = 1

boolpauza = nil -- nu este setare
boolday = nil
boolweek = nil
booldescurcate = nil

-- setari in cazul in care boolsmartQ este 1 
nriapo = 300 -- numar intrebari alese pe ora
nrimem = 1200 -- numar intrebari memorate
nQpH = {} -- nr intrebari alese pe ora dintro anumita categorie
ntemp = 0
NQE = {} -- nr intrebari deja extrase dintr-o categorie
NrEx = {} -- nr intrebare extrasa

-- TriggStart is what char the commands should begin with I use ! but you can use # or whatever
TriggStart = "-"

--setari

nrmcn = 30 --numar maxim caractere nick
nrmce = 26 --numar maxim caractere nume echipa

autostart = 1
autowelcome = 1
automas = 0 -- 1 pentru a trimite mesajul singur
moddifjocdef = 4 -- mod dificulatate joc 1 -  f usor, 2 - usor, 3 - normal, 4 greu, 5 f greu -- aici modficilatate default
moddifjoc = moddifjocdef

--setari ehipe
inc = 2 -- increment pentru runs
nrme = 5 --nr maxim echipe
bonusduel = 150 --o valoare de initializare setarea se gaseste in setari

bonusHour = 250
bonusDay = 1000
bonusWeek = 2000
bonuslinie = 100


boolsocket = 1 -- este corect instalat lua socket


-- Theese are the different triggers I've tried to name them so that one easily understand what they do!
-- I include TriggStart and then the word within "" this word is not casesensitive!
JoinTrigg = TriggStart.."join"
PartTrigg = TriggStart.."part"
StartTrigg = TriggStart.."start"
StopTrigg = TriggStart.."stop"
PauzaTrigg = TriggStart.."pauza"
WordTrigg = TriggStart.."word"
QuizTrigg = TriggStart.."question"
RestartTrigg = TriggStart.."resetpoints"
PointTrigg = TriggStart.."points"
ScoreTrigg = TriggStart.."scores"
PlayerTrigg = TriggStart.."players"
QuestionsTrigg = TriggStart.."questions"
ReloadTrigg = TriggStart.."reload"
HelpTrigg = TriggStart.."help"
HelpTxtTrigg = TriggStart.."helptxt"
ExtraHelpTrigg = TriggStart.."help+"
SaveTrigg = TriggStart.."savescores"
LoadTrigg = TriggStart.."loadscores"
ModeTrigg = TriggStart.."mode"
TopTrigg = TriggStart.."top"
TopTriggE = TriggStart.."tope"
TopHourTrigg = TriggStart.."tophour"
TopDayTrigg = TriggStart.."topday"
TopWeekTrigg = TriggStart.."topweek"
TopRunTrigg = TriggStart.."toprun"
TopRunTriggE = TriggStart.."toperun"
TopHourRunTrigg = TriggStart.."tophourrun"
TopDayRunTrigg = TriggStart.."topdayrun"
TopWeekRunTrigg = TriggStart.."topweekrun"
TopTriggLuky = TriggStart.."toplucky"
TopTriggAll = TriggStart.."topall"
TopTriggDuel = TriggStart.."topd"
TopTriggDuelZ = TriggStart.."topdz"
SetTrigg = TriggStart.."set"
SetariTrigg = TriggStart.."setari"



AddTrigg = TriggStart.."addq"
ModqTrigg = TriggStart.."modq"
--duel
DuelTrigg =TriggStart.."duel"
DueltTrigg =TriggStart.."duelt"
DueltaTrigg =TriggStart.."duelta"
AcceptDuelTrigg =TriggStart.."aduel"
DDuelTrigg = TriggStart.."dduel"
AcceptDDuelTrigg = TriggStart.."adduel"

--motd
writemotdTrigg = TriggStart.."motd"
createmotdTrigg = TriggStart.."createmotd"

--team

AddTeamTrigg = TriggStart.."addteam"
AddMemberTrigg = TriggStart.."addmember"
DelMemberTrigg = TriggStart.."delmember"
ShowMeTeamTrigg = TriggStart.."topmyteam"
ShowTeamTrigg = TriggStart.."showteam"
TopTriggTeam = TriggStart.."topteam"
ShowTeamDayTrigg = TriggStart.."topteamday"
ShowTeamsTrigg = TriggStart.."showTeams"
LeaveTeamTrigg = TriggStart.."leaveteam"

--statistici
TopTriggVMT = TriggStart.."topv"
TopTriggVI = TriggStart.."topvi"
TopTriggEVI = TriggStart.."topevi"
TopTriggVR = TriggStart.."topvr"
TopTriggEVR = TriggStart.."topevr"
TopTriggPPR = TriggStart.."topr"
TopTriggP = TriggStart.."topp"
TopTriggRec = TriggStart.."toprec"
SITrigg = TriggStart.."si"
SIPTrigg = TriggStart.."sip"
SallRTrigg = TriggStart.."showallrang"
myduelTrigg = TriggStart.."myduel"


--reparfile
scrieTrigg = TriggStart.."scrie"
reparTrigg = TriggStart.."reparfile"
showQTrigg = TriggStart.."showq"
reloadQTrigg = TriggStart.."reloadq"
scriuQTrigg = TriggStart .."scriuq"
loadsaveHTrigg = TriggStart .."loadsaveH"
loadsaveDTrigg = TriggStart .."loadsaveD"
scrieQTrigg = TriggStart.."scrieQ"
showlogTrigg = TriggStart.."slc"

boolRunning = false
TimerTicks = 0

modulavantajduel = 0
moddescurcate = 0
modulduel = 0
booljointeam = nil
coleg = nil
nrast = 0
numarator = 0
punctedate = 0
indexmas = 0
extrasc = 0
extrasc1 = 0
extrasc2 = 0
extrasc3 = 0
extrasc4 = 0
extrasc5 = 0
extrasc6 = 0
indexator1 = 0
indexator2 = 0
boolresetetern = 0
boolresetduel = 0
boolresetstatisticiintrebari = 0
minK = 0
nmj = 0
i = 0
indqr = 0
bsc = 0
contor = 0
runda = 0
nameteam = {}
teamArray = {}
pointteam = {}
pointiniteam = {}
winner = {}
validareuser= {}
raspunszilnicArray = {}
meldeextras = {}
nrexceptat = {}
categorie_primaQ = {}
categorie_ultimaQ = {}
categorie_nume = {}
categorie_nrQ = {}
categorie_nrQexpH = {}
categorie_nrQapH = {} 
question_categorie = {}
question_autor = {}
question_dificultate = {}
aleator_cat = {}
setare = {}
q21 = {}
q2 = {}
stareQ = {}
tsc = 0
hsc = 0
nr = 0
ac = 0
ver = 0
tipduel = 0   -- valoare de initializare pentru ca tipduel sa nu fie nil
verificnameteam = 0
bcount = 0
scount = 0
sQuestion = ""
sAnswer = ""
primul = {}
tempo = {}
tempor = {}
liniecitita = {}
guessArray = {}
GuessArray = {}
strikeArray = {}
nrintrebaridef = 0
playerArray = {}
pointArray = {}
vitreArray = {}
vittastArray = {}
runEternArray = {}
pointEternArray = {}
pointHourArray = {}
pointDayArray = {}
pointWeekArray = {}
bestRun = {}
bestHourRun = {}
bestDayRun = {}
bestWeekRun = {}
jucatorcompensare = {}
jucatorwiner = {}
extrase = {}
luky = {}
aw = {}
mestemp = {}
edenuser = {}
categorii = {}
dueljucate = {}
duelcastigate = {}
duelcastigateazi = {}
duelpierdute = {}
duelegal = {}
duelcumizaazi = {}
intrebareextrasa = {}
recordintrebare = {}
recordman = {}
bestvitdereactie = {}
nrQref = {}
Qref = {}
nrintdetinute = {}
nrintrebaricat = {}
limsupcat = {}
categoria = {}
autorul = {}
dificultate = {}
lngWord = 0
lngPassed = 0
lngHinted = 0
stoptimef = 0
indexhold = 0
indexholdh = 0
indexx = 0
asd = 0
contordduel = 0
existacoleg = 0
indexintrebarinerezolvate = 0
indexintrebarinerezolvateh = 0
modintrebare = 0
numarsector = 0
numarmerlin = 0
rundacompensare = 0
numarintrebaredinset = 0
numarintrebaresinonime = 0
nrcurentj = 0
nrcurentjw = 0
numarindexdesc = 0
liniutze = "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
liniutze1 = "+++-------===-------+++-------===-------+++-------===-------+++-------===-------+++"
liniutze2 = "------------------------------------------------------------------------------"
liniutze3 = "-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-"
liniutze4 = "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
strWord = ""
strQuestion = ""
strSolved = ""
strNr = ""
strNrv = {} -- numarul intrebarii
curenthour = ""
curentday = ""
curentweek = ""
PH = {} -- premii orare dupa scor
PRH = {} -- premii orare dupa run
PSH = {} --premiu orar speed
PD = {} -- premii silnice dupa scor
PRD = {} -- premii zilnice dupa run
PW = {} -- premii saptamanale dupa scor
PRW = {} -- premii saptamanale dupa run
NRTIR = {} --numar total de intrebari raspunse
NRIRP = {} -- numar intrebari raspunse primul
NRCT = {} -- numar caractere tastate
TTR = {} -- timp total de raspuns
TMR = {} --Timp mediu de raspuns TTR/NRTIR
VMT = {} -- viteza medie de raspuns NRCT/TTR
PPR = {} --procent de raspuns primul NRIRP*100/NRTIR
NRTIRH = {} --numar total de intrebari raspunse
NRIRPH = {} -- numar intrebari raspunse primul
NRCTH = {} -- numar caractere tastate
TTRH = {} -- timp total de raspuns
TMRH = {} --Timp mediu de raspuns TTR/NRTIR
VMTH = {} -- viteza medie de tastat NCR/TTR
PPRH = {} --procent de raspuns primul NRIRP*100/NRTIR
RANG = {}
Bvi = {} --  cea mai buna viteza instantanee in caractere pe secunda
alfaa = {}
marimiorare = { NRTIRH, NRIRPH, NRCTH, TTRH, TMRH, VMTH, PPRH }
merlin = { "abracadabra","hocus_pocus","supercalifragilistic","sesam_deschide-te","hocuspocuspreparatus","supercalifragilisticexpialidocious","marmotainveleaciocolatanstaniol","capracrapapiatranpatrucumiacrapatcapulcaprei","eupuppoalapopiipopapupapoalamea" }
iniVector = { PH, PRH, PD, PRD, PW, PRW, NRTIR, NRIRP, NRCT, TTR, TMR, VMT, PPR, NRTIRH, NRIRPH, NRCTH, TTRH, TMRH, VMTH, PPRH, pointArray, pointHourArray, pointWeekArray, pointDayArray, bestRun, bestHourRun, bestDayRun, bestWeekRun, luky , RANG, PSH, Bvi, vittastArray } 
rang = { "Guest","Rookie","Cop","Chichen","Sheep","Monkey","Dolphin","Beginner","Candidate","Student","Specialist","Master","Dean","Mega_Dean","Giga_Dean","Teacher","Doctor","Omniscient","HomoSmartus","MegaBrain","EinStein"
,"Artificial_Intelligence","Haxor","Champion","Rarity","Voodoo_Master"}
rank = { 0, 1, 4, 7, 10, 12, 15, 18, 20, 25, 30, 50, 75, 100, 120, 150, 175, 200, 250, 300, 350, 400, 450, 500, 600, 700}

strBanner = " Ok Boss!!!"
strStart = BotName..ScriptVersion.." started! "..strBanner
strStopp = BotName..ScriptVersion.." stopped! "..strBanner
---------------[ End global variables ]---------------

--Function
--------------------------------------------------------------------------------
-- Send global message to one user
--------------------------------------------------------------------------------
function SendGMToUser(data, nick)
--------------------------------------------------------------------------------
	result, err = VH:SendDataToUser("<" .. BotName .. "> " .. data .. "|", nick)
	if not result then
		error("Lua script error: in VH:SendDataToUser ("..err..")")
	end
end
--------------------------------------------------------------------------------
-- Send private message to one user
--------------------------------------------------------------------------------
function SendPMToUser(data, nick)
--------------------------------------------------------------------------------
	result, err = VH:SendDataToUser("$To: " .. nick .. " From: " .. BotName .. " $<" .. BotName .. "> " .. data .. "|", nick)
	if not result then
		error("Lua script error: in VH:SendDataToUser ("..err..")")
	end
end
--------------------------------------------------------------------------------
function SendGMToAll(nick, data)
--------------------------------------------------------------------------------
	result, err = VH:SendDataToAll("<" .. nick .. "> " .. data .. "|", 0, 10)
	if not result then
		error("Lua script error: in VH:SendDataToAll ("..err..")")
	end
end
--------------------------------------------------------------------------------
function IsOP(nick)
--------------------------------------------------------------------------------
	result, data = VH:GetUserClass(nick)
	if not result then
		error("Lua script error: in VH:GetUserClass ("..err..")")
	end
	if data > 3 then
		return true
	else
		return false
	end
end
--------------------------------------------------------------------------------
function IsOw(nick)
--------------------------------------------------------------------------------
	result, data = VH:GetUserClass(nick)
	if not result then
		error("Lua script error: in VH:GetUserClass ("..err..")")
	end
	if data == 10 then
		return true
	else
		return false
	end
end
--------------------------------------------------------------------------------
function IsAd(nick)
--------------------------------------------------------------------------------
	result, data = VH:GetUserClass(nick)
	if not result then
		error("Lua script error: in VH:GetUserClass ("..err..")")
	end
	if data == 5 then
		return true
	else
		return false
	end
end
--------------------------------------------------------------------------------
function IsGu(nick)
--------------------------------------------------------------------------------
	result, data = VH:GetUserClass(nick)
	if not result then
		error("Lua script error: in VH:GetUserClass ("..err..")")
	end
	if data == 0 then
		return true
	else
		return false
	end
end
---------------[ End helper functions ]---------------

---------------[ Functions ]---------------
--function VH_OnUserLogin(curUser)
--	SendGMToUser("Welcome...."..curUser.."  da si u un   /fav    in main. Clipe frumoase!",curUser)
--	return 1
--end

function VH_OnParsedMsgAny(ip, data)
	DataArrival(data)
	return 1
end

function DataArrival(data)
	data = data .. " " -- There is a problem with pattern matching I don't know why... Just add a space to the end.
	local boolPlaydata = nil
	if (string.sub(data, 1, 1) == "<") then
		_, _, curUser = string.find(data, "^<(%S+)>%s+")
		data = string.sub(data, 1, (string.len(data) - 1))
		boolPlaydata = 1
	elseif (string.sub(data, 1, 4) == "$To:") then
		_, _, curUser = string.find(data, "From:%s+(%S+)")
		data = string.sub(data, 1, (string.len(data) - 1))
		local _, _, whoTo = string.find(data,"$To:%s+(%S+)")
		if (whoTo == BotName) then
			data = string.sub(data, (15 + string.len(BotName) + string.len(curUser)))
		end
	else
		return
	end
	
	local bOp = IsOP(curUser)
	local bOw = IsOw(curUser)
	local bAd = IsAd(curUser)
	
	local _, _, firstWord = string.find(data, "%b<>%s+(%S+)")
	
	if (firstWord ~= nil) then
		if ((string.lower(firstWord) == string.lower(HelpTrigg)) or (string.lower(firstWord) == string.lower(ExtraHelpTrigg))) then
			showfisier(strTrivHelpTxtFile)
		elseif (string.lower(firstWord) == string.lower(HelpTxtTrigg)) then
			showfisier(strTrivHelpTxtFile)
	elseif (string.lower(firstWord) == string.lower(SaveTrigg)) then
		if (bOp) then
			SaveScores(curUser)
		end
	elseif (string.lower(firstWord) == string.lower(SetariTrigg)) then
		if (bOw) then
			cmd = SetariTrigg
			showfisier(strTrivSetari)
			sendsetariactuale()
			showfisier(strTrivLogSet)
			scrielogowcmd()
		end
	elseif (string.lower(firstWord) == string.lower(showlogTrigg)) then
		if (bOw) then
			cmd = showlogTrigg
			showfisier(strTrivLog)
			scrielogowcmd()
		end
	elseif (string.lower(firstWord) == string.lower(PauzaTrigg)) then
		if (bOw) then
			cmd = PauzaTrigg
			boolpauza = 1
			scrielogowcmd()
		end
	elseif (string.lower(firstWord) == string.lower(scrieQTrigg)) then
		if (bOw) then
			cmd  = scrieQTrigg
			SendToPlayers(mesaje[1])
			scriuQ()
			scrielogowcmd()
		else
			SendToPlayers(mesaje[2])
		end
	elseif (string.lower(firstWord) == string.lower(AddTeamTrigg)) then
		if (bOw) then
			cmd = AddTeamTrigg
			SendToPlayers(mesaje[3])
			s,e,nume,numr = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			nr = tonumber(numr)
			cmd = cmd..nume.."-"..numr
			addteam()
			scrielogowcmd()
		end
	elseif (string.lower(firstWord) == string.lower(scriuQTrigg)) then
		if (bOw) then
			scriecategorii()
		end
	elseif (string.lower(firstWord) == string.lower(showQTrigg)) then
		if (bOw) or (bAd) then
			s,e,nrQ = string.find(data, "%b<>%s+%S+%s+(.+)")
			nrQ = tonumber(nrQ)
			showq()
		end
	elseif (string.lower(firstWord) == string.lower(LoadTrigg)) then
		if (bOp) then
			LoadScores(curUser)
		end
	elseif (string.lower(firstWord) == string.lower(DDuelTrigg)) then
		s,e,colegduel = string.find(data, "%b<>%s+%S+%s+(.+)")
		InitierePuncte()
		if not colegduel then
			SendToPlayers(curUser..mesaje[4])
		else
			if (modulduel == 0) then
				if colegduel == curUser then
					SendToPlayers(curUser..mesaje[5])
				else
					modulduel = 1
					existacoleg = 0
					contordduel = 0
					colegduel1 = colegduel
					tipduel = 3 -- tipduel 3 duel la dublu 2 contra doi
					SendToPlayers(curUser..mesaje[6]..colegduel1)
					duelist1 = curUser
					duelist2 = nil
					duelist3 = nil
					duelist4 = nil
				end
			elseif (modulduel == 1) then SendToPlayers(mesaje[7])
			elseif (modulduel == 2) then SendToPlayers(mesaje[8])
			end
		end
	elseif (string.lower(firstWord) == string.lower(DuelTrigg)) then
		InitierePuncte()
		if (modulduel == 0) then
			modulduel = 1
			tipduel = 1
			SendToPlayers(curUser..mesaje[9])
			duelist1 = curUser
		elseif (modulduel == 1) then SendToPlayers(mesaje[10])
		elseif (modulduel == 2) then SendToPlayers(mesaje[8])
		end
	elseif (string.lower(firstWord) == string.lower(DueltTrigg)) then
		InitierePuncte()
		if (modulduel == 0) then
			s,e,tinta,miza = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			if not duelcumizaazi[tinta] then duelcumizaazi[tinta] = 0 end
			if not duelcumizaazi[curUser] then duelcumizaazi[curUser] = 0 end
			verificaremiza = 0
			if duelcumizaazi[tinta] > 0 then verificaremiza = 1 end
			if duelcumizaazi[curUser] > 0 then verificaremiza = 1 end
			if verificaremiza == 0 then
			if not miza then
				SendToPlayers(curUser..mesaje[12])
			else
			miza = tonumber(miza)
			if miza <= 500 then
			tipduel = 2 -- tipul duelului 1 cel general catre oricine, 2 catre o tinta
			modulduel = 1
			SendToPlayers(curUser..mesaje[13]..tinta..mesaje[14]..miza..mesaje[15] )
			duelist1 = curUser
			else
				SendToPlayers(mesaje[16])
			end
			end
			else
				SendToPlayers(tinta..mesaje[17])
			end
		elseif (modulduel == 1) then SendToPlayers(mesaje[18])
		elseif (modulduel == 2) then SendToPlayers(mesaje[19])
		end
	elseif (string.lower(firstWord) == string.lower(DueltaTrigg)) then
		InitierePuncte()
		if (modulduel == 0) then
			s,e,tinta,miza = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			if not duelcumizaazi[tinta] then duelcumizaazi[tinta] = 0 end
			if not duelcumizaazi[curUser] then duelcumizaazi[curUser] = 0 end
			verificaremiza = 0
			if duelcumizaazi[tinta] > 0 then verificaremiza = 1 end
			if duelcumizaazi[curUser] > 0 then verificaremiza = 1 end
			if verificaremiza == 0 then
			s,e,tinta,miza = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			modulavantajduel = tonumber(1)
			if not miza then
				SendToPlayers(curUser..mesaje[20] )
			else
			miza = tonumber(miza)
			if miza <= 500 then
			tipduel = 2 -- tipul duelului 1 cel general catre oricine, 2 catre o tinta
			modulduel = 1
			SendToPlayers(curUser..mesaje[13]..tinta..mesaje[14]..miza..mesaje[21] )
			duelist1 = curUser
			else
				SendToPlayers(mesaje[22] )
			end
			end
			else
				SendToPlayers(tinta..mesaje[23] )
			end
		elseif (modulduel == 1) then SendToPlayers(mesaje[7])
		elseif (modulduel == 2) then SendToPlayers(mesaje[8])
		end
	elseif (string.lower(firstWord) == string.lower(AcceptDuelTrigg)) then
		InitierePuncte()
		if (modulduel == 1) then
			if tipduel == 1 then
				if (curUser ~= duelist1) then
					modulduel = 2
					SendToPlayers(curUser..mesaje[24])
					duelist2 = curUser
				else
					SendToPlayers(mesaje[25])
				end
			elseif tipduel == 2 then
				if (curUser ~= duelist1) then
					if curUser == tinta then
						modulduel = 2
						SendToPlayers(curUser..mesaje[26]..duelist1)
						duelist2 = curUser
					if modulavantajduel == 1 then
						intrebari2 = 5
					end
					else
						SendToPlayers(curUser..mesaje[27])
					end
				else
					SendToPlayers(mesaje[25])
				end
			end
		elseif (modulduel == 0) then SendToPlayers(mesaje[28])
		elseif modulduel == 2 then SendToPlayers(mesaje[8])
		end
	elseif (string.lower(firstWord) == string.lower(AcceptDDuelTrigg)) then
		verificaredduel = 0
		InitierePuncte()
		if (modulduel == 1) then
			if tipduel == 3 then
				if curUser == duelist1 then verificaredduel = 1 end
				if duelist2 ~= nil then
					if curUser == duelist2 then verificaredduel = 1 end
				end
				if duelist3 ~= nil then
					if curUser == duelist3 then verificaredduel = 1 end
				end
				if duelist4 ~= nil then
					if curUser == duelist4 then verificaredduel = 1 end
				end
				if verificaredduel == 0 then
					if curUser == colegduel1 then
						SendToPlayers(curUser..mesaje[29]..duelist1)
						duelist3 = curUser
						if duelist4 ~= nil then
							modulduel = 2
						end
					else
						if duelist2 == nil then
							duelist2 = curUser
							SendToPlayers(curUser..mesaje[30])
						else
							duelist4 = curUser
							SendToPlayers(curUser..mesaje[31])
							if duelist3 ~= nil then
								modulduel = 2
							end
						end
					end
				else
					SendToPlayers(curUser..mesaje[32])
				end
			else
				SendToPlayers(mesaje[33])
			end
		elseif (modulduel == 0) then SendToPlayers(mesaje[28])
		elseif modulduel == 2 then SendToPlayers(mesaje[8])
		end
	elseif (string.lower(firstWord) == string.lower(TopTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = pointArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggE)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = pointEternArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(SetTrigg)) then
		if (bOw) then
			s,e,nrset,valset = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			nrset = tonumber(nrset)
			valset = tonumber(valset)
			setare[nrset] = valset
			SendToPlayers(mesaje[11])
			scrielogset()
		end
	elseif (string.lower(firstWord) == string.lower(LeaveTeamTrigg)) then
		if (Gu) then
			SendToPlayers(curUser..mesaje[34])
		else
			leaveteam()
		end
	elseif (string.lower(firstWord) == string.lower(writemotdTrigg)) then
		writemotd()
	elseif (string.lower(firstWord) == string.lower(TopHourTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = pointHourArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopDayTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = pointDayArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopWeekTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = pointWeekArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopRunTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = bestRun
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopRunTriggE)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = runEternArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(myduelTrigg)) then
		myduel()
	elseif (string.lower(firstWord) == string.lower(TopHourRunTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = bestHourRun
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopDayRunTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = bestDayRun
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggDuel)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = duelcastigate
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggDuelZ)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = duelcastigateazi
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopWeekRunTrigg)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = bestWeekRun
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggLuky)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = luky
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggPPR)) then
		alfa = PPR
		TopTenPC(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggVMT)) then
		alfa = VMT
		TopTenPC(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggVI)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = Bvi
		TopTenP(alfa)
		if speedyH ~= "" then SendGMToUser("Current hour record: "..bestvitH.." CPS achieved by   "..speedyH, curUser) end

		if speedyD ~= "" then SendGMToUser("Current day record: "..bestvitD.." CPS achieved by   "..speedyD, curUser) end
	elseif (string.lower(firstWord) == string.lower(TopTriggEVI)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = vittastArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggRec)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		updaterecord()
		alfa = nrintdetinute
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggVR)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = bestvitdereactie
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggEVR)) then
		s,e,nrtop = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not nrtop then nrtop = 10 end
		nrtop = tonumber(nrtop)
		alfa = vitreArray
		TopTenP(alfa)
	elseif (string.lower(firstWord) == string.lower(TopTriggAll)) then
		alfa = pointArray
		topall(alfa)
	elseif (string.lower(firstWord) == string.lower(SallRTrigg)) then
		showallrang()
	elseif (string.lower(firstWord) == string.lower(TopTriggP)) then
		TopTenPP()
	elseif (string.lower(firstWord) == string.lower(SITrigg)) then
		modsi = tonumber(1)
		sentinfo()
	elseif (string.lower(firstWord) == string.lower(SIPTrigg)) then
		s,e,playercerut = string.find(data, "%b<>%s+%S+%s+(.+)")
		if not playercerut then
			SendGMToUser("Forma corecta a comenzii este -sip Player, pentru a afla informatii despre player", curUser)
		else
		if playercerut ~= curUser then
		if not pointArray[playercerut] then
			SendGMToUser("jucator "..playercerut.." nu exista", curUser)
		else
			modsi = tonumber(2)
			sentinfo()
		end
		else
			SendGMToUser("Comanda -sip o poti folosi pentru a afla statistici despre alt player, pentru tine este destul -si", curUser)
		end
		end
	elseif (string.lower(firstWord) == string.lower(ShowMeTeamTrigg)) then
		ShowMeTeam()
	elseif (string.lower(firstWord) == string.lower(ShowTeamTrigg)) then
		SnowTeam()
	elseif (string.lower(firstWord) == string.lower(ShowTeamsTrigg)) then
		ShowTeams()
	elseif (string.lower(firstWord) == string.lower(ShowTeamDayTrigg)) then
		omega = pointDayArray
		showteam(omega)
	elseif (string.lower(firstWord) == string.lower(TopTriggTeam)) then
		TopTenTeam()
	elseif (string.lower(firstWord) == string.lower(reloadQTrigg)) then
		if (bOw) then
			--reloadq()
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(AddMemberTrigg)) then
		s,e,member,nrechipa = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
		if (bOw) then
			cmd = AddMemberTrigg
			cmd = cmd.." "..member.." - "..nrechipa
			AddMember(member,nrechipa)
			scrielogowcmd()
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(DelMemberTrigg)) then
		s,e,member = string.find(data, "%b<>%s+%S+%s+(.+)")
		if (bOw) then
			cmd = DelMemberTrigg
			cmd = cmd.." "..member
			delmember(member)
			scrielogowcmd()
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(createmotdTrigg)) then
		if (bOw) then
			cmd = createmotdTrigg
			s,e,smotdnew = string.find(data, "%b<>%s+%S+%s+(.+)")
			writenewmotd()
			scrielogowcmd()
		else
			SendToPlayers(mesaje[35])	
		end
	elseif (string.lower(firstWord) == string.lower(AddTrigg)) then
		if (boolAddQuestion) then
			s,e,sQuestion,sAnswer = string.find(data, "%b<>%s+%S+%s+(.+)#(.+)")	
			AddQuestion(curUser,sQuestion,sAnswer)
		elseif (bOp) then
			s,e,sQuestion,sAnswer = string.find(data, "%b<>%s+%S+%s+(.+)#(.+)")	
			AddQuestion(curUser,sQuestion,sAnswer)
		else
			SendToPlayers("Questions cannot be added by users at this time")
		end
	elseif (string.lower(firstWord) == string.lower(ModqTrigg)) then
		if (bOw) or (bAd) then
			s,e,mQuestion = string.find(data, "%b<>%s+%S+%s+(.+)")	
			ModQuestion(curUser,mQuestion)
		else
			SendToPlayers("Questions cannot be added by users at this time")
		end

	elseif (string.lower(firstWord) == string.lower(RestartTrigg)) then
		if (bOw) then
			if curUser == owner1 or curUser == owner2 then
			s,e,boolresetetern,boolresetduel = string.find(data, "%b<>%s+%S+%s+(.+)-(.+)")
			boolresetetern = tonumber(boolresetetern)
			boolresetduel = tonumber(boolresetduel)
			cmd = RestartTrigg
			Restartall()
			StopQuiz()
			scrielogowcmd()
			else
				SendToPlayers(mesaje[35])
			end
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(loadsaveHTrigg)) then
		if (bOw) then
			cmd = loadsaveHTrigg
			calesiguranta = calesiguranta1
			loadsaveHD()
			scrielogowcmd()		
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(loadsaveDTrigg)) then
		if (bOw) then
			cmd = loadsaveDTrigg
			calesiguranta = calesiguranta2
			loadsaveHD()
			scrielogowcmd()		
		else
			SendToPlayers(mesaje[35])
		end
	elseif ((string.lower(firstWord) == string.lower(ScoreTrigg))) then
		SendPMToUser("SCORES:", curUser)
		SendPMToUser("---------------------------------------------------------", curUser)
		for index, value in pairs(pointArray) do
			SendPMToUser(index.."'s points: "..value, curUser)
		end
		SendPMToUser("---------------------------------------------------------", curUser)
	elseif (string.lower(firstWord) == string.lower(QuestionsTrigg)) then
		if (bOp) then
			SendPMToUser("TOP "..lngMaxShowList.." QUESTIONS:", curUser)
			SendPMToUser("---------------------------------------------------------", curUser)
			local lngShowMax = lngMaxShowList
			for index, value in pairs(guessArray) do
				if (lngShowMax == 0) then
					break
				end
				arrTmp = tokenize(guessArray[index], strGSep)
				strTmp = arrTmp[1]
				SendPMToUser("["..index.."] "..strTmp, curUser)
				lngShowMax = lngShowMax - 1
			end
			SendPMToUser("Total # of questions: "..nrintrebaridef, curUser)
			SendPMToUser("---------------------------------------------------------", curUser)
		end
	elseif (string.lower(firstWord) == string.lower(StartTrigg)) then
		if (bOp) then
			if (lngWord == 0) then
				SendGMToAll(BotName, strStart)
				StopQuiz(1)
			else
				SendGMToAll(BotName, "There is already a game going on type "..JoinTrigg.." to join!")
			end
		else
			SendPMToUser("Only Operators can start the Trivia because it might be off for a reason.", curUser)
		end
	elseif (string.lower(firstWord) == string.lower(StopTrigg)) then
		if (bOp) then
			HoldQuiz()
			StopQuiz()
			SendGMToAll(BotName, strStopp)
		else
			SendToPlayers(mesaje[35])
		end
	elseif (string.lower(firstWord) == string.lower(QuizTrigg)) then
		if (lngWord ~= 0) then
			SendToPlayers("Question is: "..strQuestion)
		end
	elseif (string.lower(firstWord) == string.lower(ReloadTrigg)) then
		if (bOp) then
			local _, _, secondWord = string.find(data, "%b<>%s+%S+%s+(%S+)")
			if not secondWord then secondWord = strQFile end
				if (secondWord) then
					handle = io.open(secondWord, "r")
					if (handle) then
						handle:close()
						strTrivFile = secondWord
					end
				end
				HoldQuiz()
				LoadQuestions()
			end
		else
			if ((lngWord ~= 0) and (boolPlaydata)) then
				if 1 == 1 then
					local msg = string.sub(data, (4 + string.len(curUser)))
					if (string.len(msg) >= string.len(strWord)) then
						local boolDisc = nil
						local strTurn = ""
						boolAOK = 0
						if nrrv == 1 then
							if string.lower(msg) == string.lower(strWord) then
								mesajcorect = strWord
								boolAOK = 1
							end
						else
							for index, value in pairs(varA) do
								if string.lower(msg) == string.lower(value) then
									mesajcorect = value
									boolAOK = 1
								end
							end	
						end
						if (boolAOK == 1) then
							strTurn = strWord
							boolDisc = 1
						else
							strTurn = strSolved
						end
						if (boolDisc) then
							strSolved = strTurn
						end
						if (boolAOK == 1) then
							if not validareuser[curUser] then
							InitierePuncte()
							Verificare()
							if (ver == 1) then
								ac = ac + 1
								if boolsocket == 1 then
								    require "socket"
								  traspuns = socket.gettime()
								else
								  traspuns = os.time()
								end
								traspuns = traspuns - tli
								traspuns = string.format("%.3f", traspuns)
								if not traspuns then 
									modtimps = tonumber(0)
								else
									modtimps = tonumber(1)
								end
								Iniwinner()
								LuckScore()
								HintScore()
								LenghtScore()
								bestvit()
								RunScore()
								compensarepartone()
								CalculScore()
								StatUser()
								informatii()
								rangul()
								Send()
								if not (teamArray[curUser]) then
									ncsss = 0
								else
									PointTeam()
								end
							end
							else
								SendToPlayers(curUser..mesaje[36])
							end
							if (ac == 4) then
								lngPassed = lngMaxTime
								HoldQuiz()
							end
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------
function HoldQuiz()
-----------------------------------------------------------------------------------------
	indexhold = indexhold + 1
	indexholdh = indexholdh + 1
	if indexhold == 1 then
		--reloadq()
		--initiereparametrii()
		--inirangul()
		modulok = tonumber(1) -- pentru a nu mai trimite initierea rangului la pornirea triviei
	end
	SaveScores()
	for index, value in pairs(validareuser) do
		validareuser[index] = validareuser[index] + 1
		if validareuser[index] >= 5 then
			validareuser[index] = nil
			SendToPlayers(index..mesaje[37])
		end
	end
	varA = {}	
	strWord = ""
	strQuestion = ""
	strSolved = ""
	--SendToPlayers("I'm ok.")
	BonusScore()
	ac = 0
	ver = 0
	aw = {}
	if (modulduel ~= 0) then
		Duel()
	end
	winner = {}
	sistime = os.time()
	if sistime > (stoptimef + 1200) or stoptimef == 0 then
	if not booldescurcate then
		bdfrate = math.random(1,30)
		if bdfrate == 5 then
			booldescurcate = 1
			moddescurcate = moddescurcate + 1
			SendToPlayers("\r\n"..liniutze.."\r\n   "..mesaje[38].." \r\n " ..mesaje[39].." \r\n "..mesaje[40].."\r\n"..liniutze.."\r\n")
			starttimef = sistime
			if moddescurcate > 2 then
				moddescurcate = 1
			end
			if moddescurcate == 2 then
				boolAutoHint = nil
			end
		end
	end
	end
	if booldescurcate and sistime > (starttimef + 180) then
		booldescurcate = nil
		boolAutoHint = 1
		stoptimef = sistime
		SendToPlayers("\r\n"..liniutze.." \r\n"..mesaje[41].." \r\n"..liniutze.."\r\n")
	end
	if not boolpauza then
		if (modulduel ~= 0) then
			TimerTicks = lngRestTime * 7
		else
			TimerTicks = lngRestTime * 5
		end
		compensareparttwo()
	else
		--alegeQ()
		indexator1 = 0
		LoadQuestions()
		TimerTicks =120
		boolpauza = nil
		SendToPlayers(mesaje[42].."  \r\n"..liniutze)
		if boolhour then
			if boolsalvarifisiere then
			numecale = calesiguranta1
			updatefisiere()
			SaveScores()
			savenameteam()
			numecale = caledefault
			updatefisiere()
			end
			alfa = bestHourRun
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			end
			Reset(alfa)
			SaveScores()
			alfa = pointHourArray
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
				--SendToPlayers("\r\n"..liniutze)
			else
				SendToPlayers(mesaje[43])
			end
			Reset(alfa)
			SaveScores()
			alfa = VMTH
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
				SendToPlayers("\r\n"..liniutze)
			end
			Reset(alfa)
			punctedate = 0
			for index, value in pairs(marimiorare) do
				alfa = marimiorare[index]
				Reset(alfa)
			end
			SaveScores()
			boolhour = nil
			writemotd()
			SendToPlayers(mesaje[44]..indexholdh..mesaje[45]..indexintrebarinerezolvateh..mesaje[46])
			indexholdh = 0
			indexintrebarinerezolvateh = 0
			if bestvitD == 0 then
				bestvitD = bestvitH
				speedyD = speedyH
			end
			if speedyH ~= "" then
				SendToPlayers("\r\n "..mesaje[47]..speedyH.." - "..bestvitH..mesaje[48].." \r\n")
			end
			local handle = io.open(strTrivIniMFile, "w")
			handle:write(bestvitH..strGSep..bestvitD..strGSep..speedyH..strGSep..speedyD.."\r\n")
			handle:close()
			alfa = pointHourArray
			Reset(alfa)
			speedyH = ""
			bestvitH = 0
		end
		if boolday then
			if boolsalvarifisiere then
			numecale = calesiguranta2
			updatefisiere()
			SaveScores()
			savenameteam()
			numecale = caledefault
			updatefisiere()
			end
			alfa = bestDayRun
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			end
			Reset(alfa)
			SaveScores()
			alfa = pointDayArray
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			else
				SendToPlayers(mesaje[43])
			end
			Reset(alfa)
			alfa = duelcastigateazi
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			end
			if speedyD ~= "" then
				SendToPlayers("\r\n "..mesaje[49]..speedyD.." - "..bestvitD..mesaje[48].." \r\n")
			end
			local handle = io.open(strTrivIniMFile, "w")
			handle:write(bestvitH..strGSep..bestvitD..strGSep..speedyH..strGSep..speedyD.."\r\n")
			handle:close()
			speedyD = ""
			bestvitD = 0
			Reset(alfa)
			alfa = pointHourArray
			Reset(alfa)
			alfa = pointDayArray
			Reset(alfa)
			punctedate = 0
			SaveScores()
			scrieduel()
			duelcumizaazi = {}
			boolday = nil
		end
		if boolweek then
			alfa = bestWeekRun
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			end
			Reset(alfa)
			SaveScores()
			alfa = pointWeekArray
			TopFirst(alfa)
			if punctedate ~= 0 then
				TopTen(alfa)
				premiere(alfa)
			else
				SendToPlayers(mesaje[43])
			end
			punctedate = 0
			boolweek = nil
			Reset(alfa)
			alfa = pointHourArray
			Reset(alfa)
			alfa = pointDayArray
			Reset(alfa)
			alfa = pointWeekArray
			Reset(alfa)
			SaveScores()
		end
		SendToPlayers(mesaje[50].." \r\n"..liniutze)
	end
end
-----------------------------------------------------------------------------------------
function StopQuiz(restart)
-----------------------------------------------------------------------------------------
	boolRunning = false
	lngWord = 0
	lngPassed = 0
	strWord = ""
	strQuestion = ""
	strSolved = ""
	TimerTicks = 0
	if (restart) then
		StartQuiz()
	end
end
------------------------------------------------------------------------------------------
function alegeintrebarea()
------------------------------------------------------------------------------------------
	nrj = tonumber(ordercategory[indexator1])  -- numarulcategoriei
	nrQj = NrQcat[nrj] -- nr de intrebari din categoria nrj
	BazaQ = {}
	indexatorq = 0
	indexbaza = 0
	for index in pairs(NrQcat) do
		if index < nrj then
			indexbaza = indexbaza + NrQcat[index]
		end
	end
	nrqiesitepecat = 0
	for index, value in pairs(GuessArray[nrj]) do
		indexatorq = indexatorq + 1
		indexqact = indexbaza + indexatorq
		if stareQ[indexqact] == 1 then
			nrqiesitepecat = nrqiesitepecat + 1
		end
	end
	indexatorq = 0
	limreset = 0.8 * nrQj
	if nrqiesitepecat > limreset then
		SendToPlayers( mesaje[51]..nrj..mesaje[52]..nrqiesitepecat)
		for index, value in pairs(GuessArray[nrj]) do
			indexatorq = indexatorq + 1
			indexqact = indexbaza + indexatorq
			stareQ[indexqact] = 0
		end
		SendToPlayers(mesaje[53]..category[nrj])
	end
	nrintrebaribaza = 0
	indexatorq = 0	
	for index, value in pairs(GuessArray[nrj]) do
		indexatorq = indexatorq + 1
		indexqact = indexbaza + indexatorq
		if stareQ[indexqact] == 0 then
			nrintrebaribaza = nrintrebaribaza +1
			table.insert(BazaQ, indexatorq)
		end
	end
	lngWord = math.random(1, nrintrebaribaza)
	lngWord = tonumber(BazaQ[lngWord])
	lngWord = lngWord + indexbaza
end
--------------------------------------------------------------------------------
function trimiteintrebarea()
--------------------------------------------------------------------------------
	lngQuestion = nrintrebaridef
	modintrebare = 1 -- pentru modintrebare = 2 nu se permite record de intrebare inainte era interzis pentru strike nush dc :)
	indexator2 = indexator2 + 1
	indexator1 = indexator1 + 1
------------------------ Alegere veche -----------------------------------------
	--intermediar = tonumber(numerealese[indexator1])
	--lngWord = NrEx[intermediar]
--------------------------------------------------------------------------------
	alegeintrebarea()
	if not guessArray[lngWord] then
		trimiteintrebarea()
	end
	varA = {}
	nrrv = 1 -- numar de raspunsuri valide pentru o intrebare
	QWarray = tokenize(guessArray[lngWord], strGSep)
	for index, value in pairs(QWarray) do
		nrrv = nrrv + 1
		if index >= 2 then
			if not value or value == "" then
				SendToPlayers(" Intrebarea "..lngWord.." are o eroare!")
			else
				table.insert(varA , value)
			end
		end
	end
	nrrv = nrrv - 2 -- scazut doi unu pentru ca initializarea pleaca de la unu si unu pentru ca primu array e intrebarea
	for index, value in pairs(varA) do
		if index == 1 then
			minvarA = value
		else
			if string.len(minvarA) > string.len(value) then
				minvarA = value
			end
		end
	end
	strNr = lngWord
	strQuestion = QWarray[1]
	strWord = minvarA
	if string.len(minvarA) == 0 then
		indexator2 = indexator2 - 1
		indexator1 = indexator1 - 1
		SendToPlayers("Eroare evitata ( lungimea raspunsului zero ")
		stareQ[lngWord] = 0
		trimiteintrebarea()
		return		
	end
	if indexator2 == 1 then 
		BotName = BotName1
	else
		BotName = BotName2
		indexator2 = 0
	end
	strSolved = ""
	if not strQuestion then 
		trimiteintrebarea()
		return
	end
	if not strWord then 
		trimiteintrebarea()
		return
	end
	if not strNr then 
		trimiteintrebarea()
		return
	end
end
-----------------------------------------------------------------------------------------
function StartQuiz()
-----------------------------------------------------------------------------------------
	if (curenthour ~= tonumber(os.date("%H"))) then
		curenthour = tonumber(os.date("%H"))
		SendToPlayers("--- --- Last Question before Pause --- ---")
		SaveIniTime()
		boolpauza = 1
		boolhour = 1
	end
	if (curentday ~= tonumber(os.date("%d"))) then
		SendToPlayers("--- --- Tomorrow becomes Today --- ---")
		curentday = tonumber(os.date("%d"))
		SaveIniTime()
		boolpauza = 1
		boolday = 1
	end
	if (curentweek ~= tonumber(os.date("%V"))) then
		SendToPlayers("--- --- Change week --- ---")
		curentweek = tonumber(os.date("%V"))
		SaveIniTime()
		boolpauza = 1
		boolweek = 1
	end
	--alegeintrebarea()
	trimiteintrebarea()
	nrmdtm = 0
	numarmerlin = numarmerlin + 1
	if numarmerlin == 1 then
		lngHintTime = 8
	end
	if numarmerlin == 100 then
		nrmerlinmax = 0
		for index, value in pairs(merlin) do
			nrmerlinmax = nrmerlinmax + 1
		end
		indmerlin = math.random(1,nrmerlinmax)
		strWord = merlin[indmerlin]
		numarmerlin = 0
		nrmdtm = 1
		nrrv = 1
	end
	cleanAns()
	for x=1, string.len(strWord) do
		if (string.sub(strWord, x, x) == " ") then
			strSolved = strSolved.." "
		else
			strSolved = strSolved..strCMask
		end
	end
	lngPassed = 0
	lngHinted = 0
	numarator = 0
	extrase = {}
	if curUsera == nil then
		if setare[1] == 1 then -- boolautoincetinire
			lngHintTime = lngHintTime + setare[2]
		end
	else
		lngHintTime = 8
	end
	if lngHintTime > setare[3] then
		lngHintTime = 8
	end
	if booldescurcate then
		--if moddescurcate == 1 then
			lngHintTime = 4
		--end
	end
	lngHintTimeCount = lngHintTime
	stabilestecatdescopar()
	boolRunning = true
	if boolsocket == 1 then
	require "socket"
	tli = socket.gettime()
	else
	  tli = os.time()
	end
	strNr = tonumber(strNr)
	asd = tonumber(strNr)
	if not (recordman[strNr]) then
		randrecordman = ""
	else
		randrecordman = " Record: "..recordintrebare[strNr].." sec. achieved by   "..recordman[strNr]
	end
	if NRH == 1 then
		randhint = " Hint. "
	else
		randhint = " Hints. "
	end
	if autorul[asd] == "Necunoscut" then
		randautor = "-:-"
	else
		randautor = "-:- Submitted by "..author[nrj]
	end
	if nrrv == 1 then
		randnrrasp = ""
	else
		randnrrasp = " Raspunsuri Posibile "..nrrv
	end
	if nrmdtm == 1 then
		rand0 = indexator1..mesaje[54]..category[nrj].." ("..nrj.. ") -- MERLIN's_affairs! -- \r\n"
	else
		rand0 = indexator1..mesaje[54]..category[nrj].." ("..nrj..")\r\n"
	end
	liniutze23 = ""
	alfa3 = 1
	alfa1 = string.len(strQuestion)
	alfa2 = 1.5 * string.len(strSolved)
	if alfa1 > 80 then
		alfa1 = 80
	end
	if alfa2 > alfa1 then
		alfa3 = 1.3
		alfa1 = alfa2 
	end
	if alfa1 < 12 then 
		alfa1 = 2.3 * alfa1 * alfa3
	else
		alfa1 = 1.55 * alfa1 * alfa3
	end
	for i = 1, alfa1 do
		liniutze23 = liniutze23.."-"
	end
	rand1 = "\t  \t"..liniutze23.."\r\n"
	rand2 = "\t  \t"..randautor.." - "..NRH..randhint..mesaje[55]..lngMaxTime.." sec."..randnrrasp.." "..randrecordman.." \r\n \t  \t"..liniutze23.. "\r\n"
	rand3 = "\t  \t -:- "..strQuestion.."           \n"
	rand4 = "\t \t -:- "..strSolved.." ( "..string.len(strSolved).." ) \r\n\t  \t"..liniutze23.." "
	if booldescurcate then
		if moddescurcate == 1 then
		numarindexdesc = numarindexdesc + 1
			if numarindexdesc == 3 or numarindexdesc == 6 then
				rand4 = "\t\t\t \t -:- _ _ _ _ _ _"
			elseif numarindexdesc == 4 or numarindexdesc == 5 then
				rand3 = "\t\t\t  \t "..mesaje[56].." \n"
			end
			if numarindexdesc == 6 then
				numarindexdesc = 0
			end	
		end
	end
	SendToPlayers(rand0..rand1..rand2..rand3..rand4)
	strNr = tonumber(strNr)
	stareQ[strNr] = 1
	savestareq()
	--SendToPlayers ("nrQ = "..strNr.."---"..tonumber(strNr))	
end
-----------------------------------------------------------------------------------------
function cleanAns() -- functia care curata raspunsul de spatii libere inainte si dupa
-----------------------------------------------------------------------------------------
	strTurnt = ""
	for x=1, string.len(strWord) do
		if (string.sub(strWord, 1, 1) ~= " ") then
			strTurnt = strTurnt..string.sub(strWord, x, x)
		end
	end
	strWord = strTurnt
	strTurnt = ""
	if (string.sub(strWord, string.len(strWord), string.len(strWord)) == " ") then
		for x=1, (string.len(strWord)-1) do
			strTurnt = strTurnt..string.sub(strWord, x, x)
		end
		strWord = strTurnt
	end

	if (string.sub(strWord, 1, 1) == " ") then cleanAns() end
	if (string.sub(strWord, string.len(strWord), string.len(strWord)) == " ") then cleanAns() end
end
-----------------------------------------------------------------------------------------
function stabilestecatdescopar()
-----------------------------------------------------------------------------------------
	alfa5 = 0
	for i = 1, string.len(strWord) do
		if string.sub(strWord, i, i) == " " then
			alfa5 = alfa5 + 1
		end
	end
	ncd = string.len(strWord) - alfa5
	if ncd == 1 then
		bcount = 0
		NRH = 0
	elseif ncd == 2 then
		bcount = 1
		NRH = 1
	elseif ncd == 3 then
		bcount = 2
		NRH = 1
	elseif ncd == 4 then
		if moddifjoc == 1 then
			bcount = 2
			NRH = 2		
		elseif moddifjoc == 2 then
			bcount = 2
			NRH = 2
		elseif moddifjoc == 3 then
			bcount = 1
			NRH = 3		
		elseif moddifjoc == 4 then
			bcount = 1
			NRH = 2
		elseif moddifjoc == 5 then
			bcount = 1
			NRH = 2
		end
	elseif ncd == 5 then
		if moddifjoc == 1 then
			bcount = 3
			NRH = 2		
		elseif moddifjoc == 2 then
			bcount = 3
			NRH = 2
		elseif moddifjoc == 3 then
			bcount = 2
			NRH = 2		
		elseif moddifjoc == 4 then
			bcount = 3
			NRH = 1
		elseif moddifjoc == 5 then
			bcount = 3
			NRH = 1
		end
	elseif ncd == 6 then
		if moddifjoc == 1 then
			bcount = 3
			NRH = 3		
		elseif moddifjoc == 2 then
			bcount = 3
			NRH = 3
		elseif moddifjoc == 3 then
			bcount = 2
			NRH = 3
		elseif moddifjoc == 4 then
			bcount = 2
			NRH = 2
		elseif moddifjoc == 5 then
			bcount = 2
			NRH = 2
		end
	elseif ncd >= 7 and ncd <= 8 then
		if moddifjoc == 1 then
			bcount = 4
			NRH = 2	
		elseif moddifjoc == 2 then
			bcount = 4
			NRH = 2
		elseif moddifjoc == 3 then
			bcount = 2
			NRH = 4
		elseif moddifjoc == 4 then
			bcount = 1
			NRH = 3
		elseif moddifjoc == 5 then
			bcount = 1
			NRH = 3
		end
	elseif ncd >= 9 and ncd <= 10 then
		if moddifjoc == 1 then
			bcount = 4
			NRH = 3	
		elseif moddifjoc == 2 then
			bcount = 4
			NRH = 3
		elseif moddifjoc == 3 then
			bcount = 3
			NRH = 3
		elseif moddifjoc == 4 then
			bcount = 3
			NRH = 2
		elseif moddifjoc == 5 then
			bcount = 3
			NRH = 2
		end
	elseif ncd >= 11 and ncd <= 15 then
		if moddifjoc == 1 then
			bcount = 5
			NRH = 3		
		elseif moddifjoc == 2 then
			bcount = 5
			NRH = 3
		elseif moddifjoc == 3 then
			bcount = 2
			NRH = 5
		elseif moddifjoc == 4 then
			bcount = 2
			NRH = 3
		elseif moddifjoc == 5 then
			bcount = 2
			NRH = 3
		end
	elseif ncd >= 15 and ncd <= 20 then
		if moddifjoc == 1 then
			bcount = 5
			NRH = 3		
		elseif moddifjoc == 2 then
			bcount = 5
			NRH = 3
		elseif moddifjoc == 3 then
			bcount = 4
			NRH = 3
		elseif moddifjoc == 4 then
			bcount = 3
			NRH = 3
		elseif moddifjoc == 5 then
			bcount = 3
			NRH = 3
		end
	else
		if moddifjoc == 1 then
			bcount = 6
			NRH = 4		
		elseif moddifjoc == 2 then
			bcount = 6
			NRH = 4
		elseif moddifjoc == 3 then
			bcount = 4
			NRH = 4
		elseif moddifjoc == 4 then
			bcount = 4
			NRH = 3
		elseif moddifjoc == 5 then
			bcount = 4
			NRH = 3
		end
	end
	lngMaxTime = lngHintTime * ( NRH + 1 )
end
-----------------------------------------------------------------------------------------
function VH_OnTimer()
-----------------------------------------------------------------------------------------
	if autostart == 1 then
		autostart = 0
		SendGMToAll(BotName, strStart)
		StopQuiz(1)
	end
	if boolRunning then
		if ac ~= 0 then
			runda = runda + 1
			if runda == 3 then
				runda = 0
				sendvarmultiple()
				lngPassed = lngMaxTime
				HoldQuiz()
			end
		end
		if TimerTicks > 0 then
			TimerTicks = TimerTicks - 1
			return
		end
		lngPassed = lngPassed + 1
		if (ac == 0) then
		if (lngPassed == lngMaxTime) then
			indexintrebarinerezolvate = indexintrebarinerezolvate + 1
			indexintrebarinerezolvateh = indexintrebarinerezolvateh + 1
			if automas == 1 then
				indexmas = indexmas + 1
				if indexmas == 5 then
					SendMesajToUseri()
					indexmas =0
				end
			end
			if (boolRevealAnswer) then
				if nrrv == 1 then
					SendGMToAll(BotName, "The correct answer: '"..strWord.."'\r\n")
				else
					strAfis = ""
					for index, value in pairs(varA) do
						if index == 1 then
							strAfis = value
						else
							strAfis = strAfis..", "..value
						end
					end
					SendGMToAll(BotName, "Raspunsuri posibile '"..strAfis.."'\r\n")
					
				end 
			else
				SendToPlayers("Answer was not solved!")
			end
			curUsera = nil
			HoldQuiz()
		elseif (lngPassed >= (lngRestTime + lngMaxTime)) then
			StopQuiz(1)
		elseif (lngPassed == lngHintTimeCount) then
			if (boolAutoHint) then
				for nn=1,bcount do
					alegenrcarrel()
					--SendToPlayers(numarator.."-"..lngRepChar)
					local strTurn = ""
					for x=1, string.len(strWord) do
						if (x == lngRepChar) then
							strTurn = strTurn..string.sub(strWord, x, x)
						else
							strTurn = strTurn..string.sub(strSolved, x, x)
						end
					end
					strSolved = strTurn
				end
				if moddifjoc == 1 then bcount = bcount - 1
				elseif moddifjoc == 2 then bcount = bcount - 1
				elseif moddifjoc == 3 then bcount = bcount
				elseif moddifjoc == 4 then bcount = bcount + 1
				elseif moddifjoc == 5 then bcount = bcount + 1
				end
				lngHinted = lngHinted + 1
				lngHintTimeCount = lngHintTimeCount + lngHintTime
				SendGMToAll(BotName3 , "-:-"..lngHinted.."-:-   "..strSolved.."\r\n ")
			end
		end
		end
	end
end
-----------------------------------------------------------------------------------------
function alegenrcarrel()
-----------------------------------------------------------------------------------------
	numarator = numarator + 1
	if numarator == 1 then
		nrexceptat = {}
		meldeextras = {}
		nrelemmultimeinitial = string.len(strWord)
		for i = 1, nrelemmultimeinitial do
			if string.sub(strWord, i, i) == " " then
				table.insert(nrexceptat, i)
			end
		end
		nrelexceptate = 0
		for index, value in pairs(nrexceptat) do
			nrelexceptate = nrelexceptate +1
		end	
		for i = 1, nrelemmultimeinitial do
			table.insert(meldeextras, i)
		end
		nrelmdeex = 0
		if nrelexceptate ~= o then
			for index, value in pairs(nrexceptat) do
				valdescos = value
				for index, value in pairs(meldeextras) do
					if value == valdescos then
						table.remove(meldeextras, index)
					end
				end
			end
		end
	end
	indexant5 = 0
	for index, value in pairs(meldeextras) do
		indexant5 = indexant5 + 1
	end
	nrelext = math.random(1, indexant5)
	lngRepChar = meldeextras[nrelext]
	table.remove(meldeextras, nrelext)
	--SendToPlayers(numarator.."-"..lngRepChar)
end
-----------------------------------------------------------------------------------------
function tokenize (inString,token)
-----------------------------------------------------------------------------------------
	_WORDS = {}
	local matcher = "([^"..token.."]+)"
	string.gsub(inString, matcher, function (w) table.insert(_WORDS,w) end)
	return _WORDS
end
-----------------------------------------------------------------------------------------
function HintScore()
-----------------------------------------------------------------------------------------
	if lngHinted == 3 then hsc = 4
		elseif lngHinted == 2 then hsc = 6
		elseif lngHinted == 1 then hsc = 8
		else hsc = 10
	end 

end
-----------------------------------------------------------------------------------------
function LenghtScore()
-----------------------------------------------------------------------------------------
	lsc = string.len(strWord)
end
-----------------------------------------------------------------------------------------
function LuckScore()
-----------------------------------------------------------------------------------------
	rn1 = math.random(1, 6)
	rn2 = math.random(1, 6)
	if rn1 == 1 and rn2 == 1 then nsc = 150
	elseif rn1 == 6 and rn2 == 6 then nsc = 100
	else nsc = 0
	end
	if (ac == 1) then
		luky[curUser] = luky[curUser] + nsc
	end
end
-----------------------------------------------------------------------------------------
function InitierePuncte()
-----------------------------------------------------------------------------------------
	if (not (pointArray[curUser])) then
		pointArray[curUser] = 0
	end
	if (not (vitreArray[curUser])) then
		vitreArray[curUser] = tonumber(15)
	end
	if (not (vittastArray[curUser])) then
		vittastArray[curUser] = 0
	end
	if (not (pointEternArray[curUser])) then
		pointEternArray[curUser] = 0
	end
	if (not (pointHourArray[curUser])) then
		pointHourArray[curUser] = 0
	end
	if (not (pointWeekArray[curUser])) then
		pointWeekArray[curUser] = 0
	end
	if (not (pointDayArray[curUser])) then
		pointDayArray[curUser] = 0
	end
	if (not (bestRun[curUser])) then
		bestRun[curUser] = 0
	end
	if (not (bestHourRun[curUser])) then
		bestHourRun[curUser] = 0
	end
	if (not (runEternArray[curUser])) then
		runEternArray[curUser] = 0
	end
	if (not (bestDayRun[curUser])) then
		bestDayRun[curUser] = 0
	end
	if (not (bestWeekRun[curUser])) then
		bestWeekRun[curUser] = 0
	end
	if (not (luky[curUser])) then
		luky[curUser] = 0
	end
	if (not (pointArray[curUser])) then
		pointArray[curUser] = 0
	end
	for index, value in pairs(iniVector) do
		if not value[curUser] then
			value[curUser] = 0
		end
	end
	if (not (bestvitdereactie[curUser])) then
		bestvitdereactie[curUser] = tonumber(15)
	end
	
end
-----------------------------------------------------------------------------------------
function Send()
-----------------------------------------------------------------------------------------

	SendGMToUser("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",curUser)
	if modtimps == 0 then
	if ac == 1 then
		if nsc == 0 then
			SendToPlayers(ac.."- "..curUser..mesaje[57]..mesajcorect..mesaje[58]..tsc..mesaje[59]..runs..mesaje[60]..rn1.."-"..rn2)
		else 
			SendToPlayers(ac.."- "..curUser..mesaje[57]..mesajcorect..mesaje[58]..tsc..mesaje[59]..runs..mesaje[60]..rn1.."-"..rn2..mesaje[61]..nsc..mesaje[62]) 
		end
	elseif ac == 4 then
		SendToPlayers(ac.."- "..curUser..mesaje[63])
	else
		SendToPlayers(ac.."-  "..curUser..mesaje[64]..tsc..mesaje[65]..hsc..mesaje[66]..lsc..mesaje[67]..bsc..". }")
	end
	if ac < 4 then
	if locul == 1 then
			if nrmj == 1 then 
				SendToPlayers(curUser..mesaje[68]..pointArray[curUser].." pts.  you are first. ")
			else				
				SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[71]..difer..mesaje[72]..concurentinf)
			end
	elseif locul == nrmj then
		SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[73]..dife..mesaje[74]..concurentsup)
	else
		SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[73]..dife..mesaje[74]..concurentsup..mesaje[71]..difer..mesaje[72]..concurentinf)
	end
	end
	else
	if ac == 1 then
		if nsc == 0 then
			SendToPlayers(ac.."- "..curUser..mesaje[57]..mesajcorect..mesaje[75]..traspuns..mesaje[76]..tsc..mesaje[59]..runs..mesaje[60]..rn1.."-"..rn2..mesaje[77]..vitdetastat..mesaje[48])
		else 
			SendToPlayers(ac.."- "..curUser..mesaje[57]..mesajcorect..mesaje[75]..traspuns..mesaje[76]..tsc..mesaje[59]..runs..mesaje[60]..rn1.."-"..rn2..mesaje[61]..nsc..mesaje[62]..mesaje[77]..vitdetastat..mesaje[48]) 
		end
	elseif ac == 4 then
		SendToPlayers(ac.."- "..curUser..mesaje[63])
	else
		SendToPlayers(ac.."-  "..curUser..mesaje[78]..traspuns..mesaje[79]..tsc..mesaje[65]..hsc..mesaje[66]..lsc..mesaje[67]..bsc..". }")
	end
	if ac < 4 then
	if locul == 1 then
			if nrmj == 1 then 
				SendToPlayers(curUser..mesaje[68]..pointArray[curUser].." pct. you are first. ")
			else
				SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[71]..difer..mesaje[72]..concurentinf)
			end
	elseif locul == nrmj then
		SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[73]..dife..mesaje[74]..concurentsup)
	else
		SendToPlayers(curUser..mesaje[68]..pointArray[curUser]..mesaje[69]..locul..mesaje[70]..nrmj..mesaje[73]..dife..mesaje[74]..concurentsup..mesaje[71]..difer..mesaje[72]..concurentinf)
	end
	end
	end
	SendGMToUser("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",curUser)
end
-----------------------------------------------------------------------------------------
function StatUser()
-----------------------------------------------------------------------------------------
	puncte = pointArray[curUser]
	difer = 0
	dife = 0
	nrmj = 0
	loc = 0
	for index, value in pairs(pointArray) do
		nrmj = nrmj + 1
		if puncte < value then
			loc =  loc + 1
			dif = value - puncte
			tempo[index] = dif
			if loc == 1 then 
				dife = dif
			end
			if dif < dife then
				dife = dif
			end
		end
	end
	locul = loc + 1
	loc = 0
	for index, value in pairs(pointArray) do
		if puncte > value then
			loc = loc + 1
			dif = puncte - value
			tempor[index] = dif
			if loc == 1 then
				difer = dif
			end
			if dif < difer then
				difer = dif
			end
		end
	end
	locull = loc + 1
	if locull == 1 then
		difer = 0
		concurentinf = " un eventual new concurent "
	end
	if locul == 1 then 
		dife = 0
		concurentsup = "tine poate"
	end
	loc = 0
	dife = tonumber(dife)
	difer =tonumber(difer)
	for index, value in pairs(tempo) do
		if tempo[index] == dife then
			concurentsup = index
		end
	end
	for index, value in pairs(tempor) do
		if tempor[index] == difer then
			concurentinf = index
		end
	end
	if locul > nrmj then
		nrmj = locul
	end
	dife = string.format("%.1f", dife)
	difer = string.format("%.1f", difer)
end
-----------------------------------------------------------------------------------------
function bestvit()
-----------------------------------------------------------------------------------------
	traspuns = tonumber(traspuns)
	bestvitdereactie[curUser] = tonumber(bestvitdereactie[curUser])
	if traspuns < bestvitdereactie[curUser] then
		bestvitdereactie[curUser] = tonumber(traspuns)
		extrasc5 = 50
		SendToPlayers(curUser..mesaje[80]..extrasc5..mesaje[81])
	end
	if traspuns < vitreArray[curUser] then
		vitreArray[curUser] = tonumber(traspuns)
	end
	vitdetastat = string.format("%.3f", lsc/traspuns)
	if not Bvi[curUser] then Bvi[curUser] = tonumber(0) end
	vitdetastat = tonumber(vitdetastat)
	Bvi[curUser] = tonumber(Bvi[curUser])
	if modintrebare == 1 then
	strNr = tonumber(strNr)
	if not recordintrebare[strNr] then
		recordintrebare[strNr] = tonumber(15)
	end
	recordintrebare[strNr] = tonumber(recordintrebare[strNr])
	traspuns = tonumber(traspuns)
	if numarmerlin ~= 0 then
	if traspuns < recordintrebare[strNr] then
		fostulrecord = recordintrebare[strNr]
		recordintrebare[strNr] = traspuns
		if not recordman[strNr] then
		recordman[strNr] = curUser
		else
		extrasc4 = 50
		SendToPlayers(recordintrebare[strNr]..mesaje[82]..strNr..mesaje[83]..extrasc4..mesaje[84]..fostulrecord..mesaje[85]..recordman[strNr])
		recordman[strNr] = curUser
		end
	end
	end
	end
	if numarmerlin ~= 0 then
	if vitdetastat > Bvi[curUser] then
		extrasc1 = extrasc1 + 50
		Bvi[curUser] = vitdetastat
		SendToPlayers(mesaje[86]..Bvi[curUser]..mesaje[87]..extrasc1..mesaje[81])
	end
	if not 	vittastArray[curUser] then vittastArray[curUser] = tonumber(0) end
	if vitdetastat > vittastArray[curUser] then
		vittastArray[curUser] = vitdetastat
	end
	if vitdetastat > bestvitH then
		extrasc3 = 100
		bestvitH = vitdetastat
		speedyH = curUser -- CEL MAI rapid pe ora pana necesar pentru anunt orar :)
		SendToPlayers(mesaje[88]..bestvitH..mesaje[89]..extrasc3..mesaje[81])
		local handle = io.open(strTrivIniMFile, "w")
		handle:write(bestvitH..strGSep..bestvitD..strGSep..speedyH..strGSep..speedyD.."\r\n")
		handle:close()
		savemarini()
	end
	if vitdetastat > bestvitD and bestvitD ~= 0 then
		extrasc6 = 300
		bestvitD = vitdetastat
		speedyD = curUser -- CEL MAI rapid pe zi pana necesar pentru anunt orar :)
		SendToPlayers(mesaje[88]..bestvitH..mesaje[90]..extrasc6..mesaje[81])
		local handle = io.open(strTrivIniMFile, "w")
		handle:write(bestvitH..strGSep..bestvitD..strGSep..speedyH..strGSep..speedyD.."\r\n")
		handle:close()
		savemarini()
	end
	end
end
-----------------------------------------------------------------------------------------
function savemarini()
-----------------------------------------------------------------------------------------
	local handle = io.open(strTrivIniMFile, "w")
	handle:write(bestvitH..strGSep..bestvitD..strGSep..speedyH..strGSep..speedyD.."\r\n")
	handle:close()
end
-----------------------------------------------------------------------------------------
function loadmarimi()
-----------------------------------------------------------------------------------------
	local handle = io.open(strTrivIniMFile, "r")
	if (handle) then
		local line = handle:read()
		local arrTmp = tokenize(line, strGSep)
		bestvitH = tonumber(arrTmp[1])
		bestvitD = tonumber(arrTmp[2])
		speedyH = arrTmp[3]
		speedyD = arrTmp[4]
		handle:close()
	end
	if not bestvitH then
		bestvitH = 0
	end
	if not bestvitD then
		bestvitD = 0
	end
	if not speedyH then
		speedyH = ""
	end
	if not speedyD then
		speedyD = ""
	end
end
-----------------------------------------------------------------------------------------
function CalculScore()
-----------------------------------------------------------------------------------------
	if (ac < 4) then
		if (ac == 2) then
			nsc = 0
			csc = 0
		end
		if (ac == 3) then
			nsc = 0
			csc = 0
		end
		extrasc = extrasc1 + extrasc2 + extrasc3 + extrasc4 + extrasc5 + extrasc6
		tsc = hsc + lsc + nsc + bsc + csc
		tsc = string.format("%.1f",tsc/ac)
		tsc = tsc + extrasc
		if booldescurcate then
			tsc = tsc*2
		end
		pointArray[curUser] = pointArray[curUser] + tsc
		pointArray[curUser] = tonumber(string.format("%.1f", pointArray[curUser]))
		pointEternArray[curUser] = pointEternArray[curUser] + tsc
		pointEternArray[curUser] = tonumber(string.format("%.1f", pointEternArray[curUser]))
		pointHourArray[curUser] = pointHourArray[curUser] + tsc
		pointHourArray[curUser] = tonumber(string.format("%.1f", pointHourArray[curUser]))
		pointDayArray[curUser] = pointDayArray[curUser] + tsc
		pointDayArray[curUser] = tonumber(string.format("%.1f", pointDayArray[curUser]))
		pointWeekArray[curUser] = pointWeekArray[curUser] + tsc
		pointWeekArray[curUser] = tonumber(string.format("%.1f", pointWeekArray[curUser]))
	end
	extrasc = 0
	extrasc1 = 0
	extrasc2 = 0
	extrasc3 = 0
	extrasc4 = 0
	extrasc5 = 0
	extrasc6 = 0
end
------------------------------------------------------------------------------------
function rescriuQ()   --rescrie fisierul de intrebari, inlocuind intrebarile cu numarul citit in fisier cu intrebari din alt fisier
-------------------------------------------------------------------------------------
	numarator = 0
	local handle = io.open(strTriqrefFile , "r")
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			 Qref[numarator] = line
			line = handle:read()
			if numarator < 5 then
			SendToPlayers(numarator)
			end
		end
		SendToPlayers(mesaje[91])
		handle:close()
	end
	numarator = 0
	local handle = io.open(strTrinrqFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			numarator = tonumber(numarator + 1)
			nrQref = tonumber(line)
			guessArray[nrQref] = nrQref.."*"..Qref[numarator]
			if numarator < 5 then
			SendToPlayers(guessArray[nrQref])
			end
			line = handle:read()
		end
		handle:close()
	end
	numarator = 0
	SendToPlayers(mesaje[92])
	local handle = io.open(strTrivreparatFile, "w")
	for index, value in pairs(guessArray) do
		handle:write(value.."\r\n")
	end
	handle:close()
end
-------------------------------------------------------------------
function transformQ3_Q2() --functie care tranforma fisier de intrebari numerotate in nenumerotate
--------------------------------------------------------------------
	local handle = io.open(strTriqrefFile , "r")
	numarator = 0
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				q2[numarator] = arrTmp[1]
				q21[numarator] = arrTmp[2]
			end
			local arrTmp1 = tokenize(line, strGSep2)
			if ((arrTmp1[1] ~= nil) and (arrTmp1[2] ~= nil)) then
				q2[numarator] = arrTmp1[1]
			end
			lungimeintrebare = string.len(q2[numarator])
			if lungimeintrebare < 15 then 
				q2[numarator] = nil
			elseif lungimeintrebare > 150 then 
				q2[numarator] = nil
			else
				 q2[numarator] = q2[numarator]..strGSep..q21[numarator]
			end

			line = handle:read()
		end
		handle:close()
	end
	numarator = 0
	local handle = io.open(strTrivreparatFile, "w")
	for index, value in pairs(q2) do
		numarator = numarator + 1
		handle:write(value.."\r\n")
	end
	handle:close()
end
-------------------------------------------------------------------
function transformQ3_Q31() --functie creata pentru sinonime
--------------------------------------------------------------------
	local handle = io.open(strTriqrefFile , "r")
	numarator = 0
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			--local arrTmp = tokenize(line, strGSep)
			--if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
			--	q2[numarator] = arrTmp[1]
			--	q21[numarator] = arrTmp[2]
			--end
			--local arrTmp1 = tokenize(line, strGSep2)
			--if ((arrTmp1[1] ~= nil) and (arrTmp1[2] ~= nil)) then
			q2int = line
			--end
			lungimeintrebare = string.len(q2int)
			if numarator == 1 then
				lungimeintrebareanterioara = 1
			end
			if lungimeintrebare ~= lungimeintrebareanterioara then
				line = line.."#####"
				table.insert(q2, line)
			end
			lungimeintrebareanterioara = tonumber(lungimeintrebare)
			--if lungimeintrebare < 15 then 
			--	q2[numarator] = nil
			--elseif lungimeintrebare > 150 then 
			--	q2[numarator] = nil
			--else
			--	 q2[numarator] = q2[numarator]..strGSep..q21[numarator]
			--end

			line = handle:read()
		end
		handle:close()
	end
	numarator = 0
	local handle = io.open(strTrivreparatFile, "w")
	for index, value in pairs(q2) do
		numarator = numarator + 1
		handle:write(value.."\r\n")
	end
	handle:close()
end
--------------------------------------------------------------------
function transformQ2_Q2() --functie care tranforma fisier de intrebari 
--------------------------------------------------------------------
	local handle = io.open(strTriqrefFile , "r")
	numarator = 0
	numaratorsecund = 0
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			numaratorsecund = numaratorsecund + 1
			arrTmp = tokenize(line, strGSep)
			if ((arrTmp[2] ~= nil) and (arrTmp[3] ~= nil)) then
				q21[numarator] = arrTmp[1]
				q2[numarator] = arrTmp[2]
			end
			SendToPlayers(q21[numarator])
			--if numaratorsecund == 100 then
			--	SendToPlayers(q21[numarator])
			--	numaratorsecund = 0
			--end
			line = handle:read()
		end
		handle:close()
	end
	--local handle = io.open(strTriqrefFile , "r")
	--numarator = 0
	--numaratorsecund = 0
	--if (handle) then
	--	local line = handle:read()
	--	while line do
	--		numaratorsecund = numaratorsecund + 1
	--		numarator = numarator + 1
	--		local arrTmp = tokenize(line, strGSep2)
	--		if ((arrTmp[2] ~= nil) and (arrTmp[3] ~= nil)) then
	--			q21[numarator] = arrTmp[1]
	--			if numaratorsecund == 100 then
	--				SendToPlayers(q21[numarator])
	--			end
	--		end
	--		line = handle:read()
	--	end
	--	handle:close()
	--end
	local handle = io.open(strTrivreparatFile, "w")
	for index, value in pairs(q2) do
		rspn = value
		q2[index] = q21[index].."*"..value
		--handle:write(q2[index].."\r\n")
	end
	handle:close()
end





--------------------------------------------------------------------------
function rescriuintrebari() -- compara raspunsurile intrebarilor succesive si scrie daca exista raspusuri succesive ( 90 % din cazuri sunt intrebari duble)
--------------------------------------------------------------------------
	numarator = 0
	local handle = io.open(strTrivreparatFile, "a")
	for index, value in pairs(guessArray) do
		numarator = numarator + 1
		if numarator == 1 then
		QWarray = tokenize(guessArray[index], strGSep)
		strQuestion = QWarray[2]
		strWord = QWarray[3]
		strNr = QWarray[1]
		else
		if not strWord then
			strWord = "#####"
		end
		raspunsul = strWord
		--raspunsul = string.lower(raspunsul)
		intrebareaant = strQuestion
		QWarray = tokenize(guessArray[index], strGSep)
		strQuestion = QWarray[2]
		strWord = QWarray[3]
		strNr = QWarray[1]
		if not strWord then
			strWord = "#####"
		end
		--strWord = string.lower(strWord)
		if string.lower(raspunsul) == string.lower(strWord) then
			handle:write(strNr.."\r\n")
		end
		end
	end
	handle:close()
	numarator = 0
end

function SaveScores()
	local handle = io.open(strTrivScoreFile, "w")
	for index, value in pairs(pointArray) do
		nmj = nmj +1
		handle:write(index..strGSep..value.."\r\n")
	end
	nrmj = nmj
	handle:close()
	nmj = 0
	local handle = io.open(strTrivScoreEternFile, "w")
	for index, value in pairs(pointEternArray) do
	if not vittastArray[index] then
		vittastArray[index] = tonumber(0)
	end
	if not runEternArray[index] then
		 runEternArray[index] = tonumber(0)
	end
	if not vitreArray[index] then
		vitreArray[index] = tonumber(15)
	end	
	handle:write(index..strGSep..value..strGSep..runEternArray[index]..strGSep..vittastArray[index]..strGSep..vitreArray[index]..strGSep.."-\r\n")
	end
	handle:close()
	local handle = io.open(strTrivScoreHourFile, "w")
	for index, value in pairs(pointHourArray) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivScoreDayFile, "w")
	for index, value in pairs(pointDayArray) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivScoreWeekFile, "w")
	for index, value in pairs(pointWeekArray) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivRunFile, "w")
	for index, value in pairs(bestRun) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivRunHourFile, "w")
	for index, value in pairs(bestHourRun) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivRunDayFile, "w")
	for index, value in pairs(bestDayRun) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivRunWeekFile, "w")
	for index, value in pairs(bestWeekRun) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivLukyFile, "w")
	for index, value in pairs(luky) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivBviFile, "w")
	for index, value in pairs(Bvi) do
		handle:write(index..strGSep..value.."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivTeamScoreFile, "w")
	handle:write(pointteam[1]..strGSep..pointteam[2]..strGSep..pointteam[3]..strGSep..pointteam[4]..strGSep..pointteam[5]..strGSep..pointteam[6]..strGSep..pointteam[7]..strGSep..pointteam[8]..strGSep..pointteam[9])
	handle:close()
	local handle = io.open(strTrivPremiiFile, "w")
	for index, value in pairs(PH) do
		handle:write(index..strGSep..value..strGSep..PD[index]..strGSep..PW[index]..strGSep..PRH[index]..strGSep..PRD[index]..strGSep..PRW[index]..strGSep..PSH[index].."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivStatFile, "w")
	for index, value in pairs(NRTIR) do
		handle:write(index..strGSep..value..strGSep..NRIRP[index]..strGSep..NRCT[index]..strGSep..TTR[index]..strGSep..TMR[index]..strGSep..VMT[index]..strGSep..PPR[index].."\r\n")
	end
	handle:close()
	local handle = io.open(strTrivStatHFile, "w")
	for index, value in pairs(NRTIRH) do
		handle:write(index..strGSep..value..strGSep..NRIRPH[index]..strGSep..NRCTH[index]..strGSep..TTRH[index]..strGSep..TMRH[index]..strGSep..VMTH[index]..strGSep..PPRH[index].."\r\n")
	end
	handle:close()
-------------------------------------------portiune care salveaza recordurile la intrebari
	for i = 1, lngQuestion do
		if not recordintrebare[i] then
			recordintrebare[i] = tonumber(15)
		end
		if recordintrebare[i] < 0 then
			recordintrebare[i] = tonumber(15)
		end
	end
	local handle = io.open(strDefTrivSpeed2File, "w")
	for index, value in pairs(recordman) do
		handle:write(index..strGSep..value..strGSep..recordintrebare[index]..strGSep.."-".."\r\n")
	end
	handle:close()
	local handle = io.open(strDefTrivSpeedFile, "w")
	for index, value in pairs(bestvitdereactie) do
		handle:write(index..strGSep..value..strGSep.."-".."\r\n")
	end
	handle:close()
	
-----------------------------------------
end
function savestareq()
	--SendToPlayers("salvez stare")
	local handle = io.open(strTrivstareqFile, "w")
	for index, value in pairs(stareQ) do
		handle:write(tonumber(index)..strGSep..tonumber(value)..strGSep.."-".."\r\n")
	end
	handle:close()
end

function SaveIniTime()
	local handle = io.open(strTrivIniTimeFile, "w")
	handle:write(curenthour..strGSep..curentday..strGSep..curentweek)
	handle:close()
end
function Reset(alfa)
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(0)
	end
end
----------------------------------------------------------------------------------------
function reloadq()
----------------------------------------------------------------------------------------
	SendToPlayers(mesaje[93])
	numarator = 0
	local handle = io.open(strTriModqFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				--SendToPlayers(arrTmp[1])
				arrTmp[1] = tonumber(arrTmp[1])
				--SendToPlayers(guessArray[arrTmp[1]])
				--SendToPlayers(line)
				guessArray[arrTmp[1]] = line

			end
			local arrTmp = tokenize(line, strGSep3)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				--SendToPlayers(arrTmp[1])
				--SendToPlayers(guessArray[arrTmp[1]])
				--SendToPlayers(line)
				guessArray[arrTmp[1]] = arrTmp[1]

			end
			line = handle:read()
		end
		handle:close()
	end
	SendToPlayers(mesaje[94]..numarator)
end
----------------------------------------------------------------------------------------
function LoadScores(curUser)
----------------------------------------------------------------------------------------
	local handle = io.open(strTrivScoreFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointArray[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivScoreHourFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointHourArray[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivScoreDayFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointDayArray[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivScoreWeekFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointWeekArray[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivRunFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				bestRun[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivScorDuelFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				dueljucate[arrTmp[1]] = tonumber(arrTmp[2])
				duelcastigate[arrTmp[1]] = tonumber(arrTmp[3])
				duelpierdute[arrTmp[1]] = tonumber(arrTmp[4])
				duelegal[arrTmp[1]] = tonumber(arrTmp[5])
				duelcastigateazi[arrTmp[1]] = tonumber(arrTmp[6])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivRunHourFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				bestHourRun[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivRunDayFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				bestDayRun[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivRunWeekFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				bestWeekRun[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivLukyFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				luky[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivBviFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				Bvi[arrTmp[1]] = tonumber(arrTmp[2])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivPremiiFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				PH[arrTmp[1]] = tonumber(arrTmp[2])
				PD[arrTmp[1]] = tonumber(arrTmp[3])
				PW[arrTmp[1]] = tonumber(arrTmp[4])
				PRH[arrTmp[1]] = tonumber(arrTmp[5])
				PRD[arrTmp[1]] = tonumber(arrTmp[6])
				PRW[arrTmp[1]] = tonumber(arrTmp[7])
				PSH[arrTmp[1]] = tonumber(arrTmp[8])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivStatFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				NRTIR[arrTmp[1]] = tonumber(arrTmp[2])
				NRIRP[arrTmp[1]] = tonumber(arrTmp[3])
				NRCT[arrTmp[1]] = tonumber(arrTmp[4])
				TTR[arrTmp[1]] = tonumber(arrTmp[5])
				TMR[arrTmp[1]] = tonumber(arrTmp[6])
				VMT[arrTmp[1]] = tonumber(arrTmp[7])
				PPR[arrTmp[1]] = tonumber(arrTmp[8])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivStatHFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				NRTIRH[arrTmp[1]] = tonumber(arrTmp[2])
				NRIRPH[arrTmp[1]] = tonumber(arrTmp[3])
				NRCTH[arrTmp[1]] = tonumber(arrTmp[4])
				TTRH[arrTmp[1]] = tonumber(arrTmp[5])
				TMRH[arrTmp[1]] = tonumber(arrTmp[6])
				VMTH[arrTmp[1]] = tonumber(arrTmp[7])
				PPRH[arrTmp[1]] = tonumber(arrTmp[8])
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strDefTrivSpeed2File, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				arrTmp[1] = tonumber(arrTmp[1])
				recordman[arrTmp[1]] = arrTmp[2]
				recordintrebare[arrTmp[1]] = tonumber(arrTmp[3])
			end
			line = handle:read()
		end
		handle:close()
	end
	for i = 1, nrintrebaridef do
		if not recordintrebare[i] then
			recordintrebare[i] = tonumber(15)
		end
		if recordintrebare[i] < 0 then
			recordintrebare[i] = tonumber(15)
		end
	end
	local handle = io.open(strDefTrivSpeedFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				bestvitdereactie[arrTmp[1]] = arrTmp[2]
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strTrivScoreEternFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointEternArray[arrTmp[1]] = tonumber(arrTmp[2])
				runEternArray[arrTmp[1]] = tonumber(arrTmp[3])
				vittastArray[arrTmp[1]] = tonumber(arrTmp[4])
				vitreArray[arrTmp[1]] = tonumber(arrTmp[5])
			end
			line = handle:read()
		end
		handle:close()
	end
	
end
-----------------------------------------------------------------------------------------
function LoadIniTime()
-----------------------------------------------------------------------------------------
	local handle = io.open(strTrivIniTimeFile, "r")
	if (handle) then
		local line = handle:read()
		local arrTmp = tokenize(line, strGSep)
		curenthour = tonumber(arrTmp[1])
		curentday = tonumber(arrTmp[2])
		curentweek = tonumber(arrTmp[3])
		handle:close()
	end
	if not curenthour then 
		curenthour = tonumber(os.date("%H"))
		curentday = tonumber(os.date("%d"))
		curentweek = tonumber(os.date("%V"))
		local handle1 = io.open(strTrivIniTimeFile, "w")
		handle1:write(curenthour..strGSep..curentday..strGSep..curentweek)
		handle1:close()
	end
end
-----------------------------------------------------------------------------------------
function AddQuestion(curUser, sQuestion, sAnswer)
-----------------------------------------------------------------------------------------
	booladdq = tonumber(0)
	local handle = io.open(strQFile, "a")
	handle:write(sQuestion..strGSep..sAnswer.."\r\n")
	SendPMToUser(curUser.." Has added the question "..sQuestion, curUser)
	SendPMToUser(curUser.." you gave the answer as "..sAnswer, curUser)
	handle:close()
end

function ModQuestion(curUser, mQuestion)
	booladdq = tonumber(0)
	local handle = io.open(strTriModqFile, "a")
	handle:write(mQuestion..strGSep3.."-\r\n")
	SendPMToUser(curUser.." Has added the question "..mQuestion, curUser)
	handle:close()
end

function showfisier(fisier)
	local handle = io.open(fisier, "r")
	numarator = 0
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			liniecitita[numarator] = line
			line = handle:read()
		end
		handle:close()
	end
	mesaj = "                          "
	for index in pairs(liniecitita) do
		mesaj = mesaj.." \r\n "..liniecitita[index].."   "
	end
	SendPMToUser(mesaj, curUser)
	mesaj = nil
	liniecitita = {}
	numarator = 0
end
function writenewmotd()
	local handle = io.open(strTrivMotd1File, "w")
	handle:write(smotdnew)
	handle:close()
	SendToPlayers("Ok boss noul motd a fost creat \r\n\t\t\t Pentru a scrie motd poti da comanda -motd.\r\n\t\t\t Sau ma lasi pe mine :P:)  la fix imi fac timp si schimb eu :P:).")
end
function writemotd()
	if boolautomotd == 1 then
	mesaj = nil
	timp = os.date("%H:%M:%S")
	local handle = io.open(strTrivMotd1File, "r")
	numarator = 0
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			liniecitita[numarator] = line
			line = handle:read()
		end
		handle:close()
	end
	mesaj = "                          "
	for index in pairs(liniecitita) do
		mesaj = mesaj.." \r\n "..liniecitita[index].."   "
	end
	numarator = 0
	local handle = io.open(strTrivMotdFile, "w")
	numarator = 0
	for index, value in pairs(liniecitita) do
		handle:write(value.."\r\n")
	end
	handle:close()
	liniecitita = {}
	alfa = pointDayArray
		local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	if alfa == pointArray then
		mesajul = "Trivia scores in "..numelehubului.."..\r\n Pos\t Score\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == pointHourArray then 
		mesajul = "Trivia scores last hour in "..numelehubului.."..\r\n Pos\t Score\t\t Nick\t\r\n ---------------------------------"
	elseif alfa == pointDayArray then 
		mesajul = "Trivia scores in this day in "..numelehubului.."..\r\n la \t\t\t"..timp.." \r\n ---------------------------------------------------------------------------------------"
	elseif alfa == pointWeekArray then 
		mesajul = "Trivia scores last week in "..numelehubului.."..\r\n Pos\t Score\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == bestRun then 
		mesajul = "Trivia bestruns in "..numelehubului.." ..\r\n Pos\t best_run\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == bestHourRun then 
		mesajul = "Trivia bestruns last hour in  "..numelehubului.."..\r\n Pos\t best_run\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == bestDayRun then 
		mesajul = "Trivia bestruns last day in "..numelehubului.."..\r\n Pos\t best_run\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == bestWeekRun then 
		mesajul = "Trivia bestruns last week in "..numelehubului.."..\r\n Pos\t best_run\t\t Nick\t\r\n -------------------------------------------"
	elseif alfa == luky then 
		mesajul = "Trivia luky scores in this "..numelehubului.."..\r\n Pos\t best_run\t\t Nick\t\r\n -------------------------------------------"
	end
	x = 0
	for index, value in pairs(alfa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	local result = "\r\nTop "..x.." "..mesajul.."  "
	for i = 1, x do
		if alfa[index[i]] ~= 0 then
			if not bestRun[index[i]] then bestRun[index[i]] = 0 end
			result = result.."\r\n "..i..".\t"..index[i].."\t\t"..alfa[index[i]].." puncte, best runs: "..bestRun[index[i]].." Rang: "..RANG[index[i]].."\r\n --------------------------------------------------------------------------------------" 
		end
	end
	msg = result
	local handle = io.open(strTrivMotdFile, "a")
	handle:write(msg.."\r\n")
	handle:close()
	msg = nil
	liniecitita = {}
	SendToPlayers(" daily score update motd ")
	end
end
-----------------------------------------------------------------------------------------------
function BonusScore()
-----------------------------------------------------------------------------------------------
	bsc = 0
	i = i + 1
	if i == 5 then bsc = 20
	elseif i == 10 then bsc = 50
	elseif i == 15 then bsc = 20
	elseif i == 20 then bsc = 50
	elseif i == 25 then bsc = 100
	elseif i == 26 then i = 0
	else i = i
	end
	bsc = tonumber(bsc)
	if (bsc ~= 0) then
		if bsc == 100 then
			SendToPlayers(mesaje[95]..bsc..mesaje[81])
			SendToPlayers(" Urmeaza intrebarea STRIKE!\r\n")
		else
			SendToPlayers(mesaje[95]..bsc..mesaje[81].." \r\n")
		end
	end
end
-----------------------------------------------------------------------------------------------
function RunScore()
-----------------------------------------------------------------------------------------------
	if ac == 1 then
	if (curUsera) then
		if curUser == curUsera then
			runs = runs + 1
			csc = inc*runs
			if runs < 11 then csc = inc*runs
				elseif runs > 11 and runs < 21 then csc = inc*(runs-10)
				elseif runs > 21 and runs < 31 then csc = inc*(runs-20)
				elseif runs > 31 and runs < 41 then csc = inc*(runs-30)
				elseif runs > 41 and runs < 51 then csc = inc*(runs-40)
				elseif runs > 51 and runs < 61 then csc = inc*(runs-50)
				elseif runs > 61 and runs < 71 then csc = inc*(runs-60)
				elseif runs > 71 and runs < 81 then csc = inc*(runs-70)
				elseif runs > 81 and runs < 91 then csc = inc*(runs-80)
				elseif runs > 91 and runs < 101 then csc = inc*(runs-90)
				elseif runs > 101 and runs < 121 then csc = inc*(runs-100)
				elseif runs > 121 and runs < 141 then csc = inc*(runs-120)
				elseif runs > 141 and runs < 161 then csc = inc*(runs-140)
				elseif runs > 161 and runs < 181 then csc = inc*(runs-160)
				elseif runs > 181 and runs < 201 then csc = inc*(runs-180)
				else csc = csc
			end
			if runs == 25 then
				csc = csc + runs*10
				SendToPlayers(mesaje[96]..csc..mesaje[97])
			end
			if runs == 50 then
				csc = csc + runs*10
				SendToPlayers(mesaje[96]..csc..mesaje[97])
			end
			if runs == 100 then
				csc = csc + runs*10
				SendToPlayers(mesaje[96]..csc..mesaje[97])
			end
		else
			runs = 1
			csc = 0
		end
	else
		runs = 1
		csc = 0
	end
	if runs > bestRun[curUser] then
		bestRun[curUser] = runs
		extrasc2 = extrasc2 + 20
		SendToPlayers(mesaje[98]..extrasc2..mesaje[81])
	end
	if runs > bestHourRun[curUser] then
		bestHourRun[curUser] = runs
	end
	if runs > runEternArray[curUser] then
		runEternArray[curUser] = runs
	end
	if runs > bestDayRun[curUser] then
		bestDayRun[curUser] = runs
	end
	if runs > bestWeekRun[curUser] then
		bestWeekRun[curUser] = runs
	end
	curUsera = curUser
	end
end
-----------------------------------------------------------------------------------------------
function SendToPlayers(msg)
-----------------------------------------------------------------------------------------------
	if (lngMode == 0) then
		SendGMToAll(BotName, msg)
	end
end
-----------------------------------------------------------------------------------------------
function SendToOthers(msg, curUser)
-----------------------------------------------------------------------------------------------
	if ((lngMode == 2) and (boolShowGuessesInPM)) then
		for index, value in pairs(playerArray) do
			if (index ~= curUser) then
				--SendPmToNick(index, BotName, "<"..curUser.."> "..msg)
				VH:SendDataToUser("<"..curUser.."> "..msg, index) -- Verlihub callback
			end
		end
	end
end
-----------------------------------------------------------------------------------------------
function SendChatToOthers(chat, curUser)
-----------------------------------------------------------------------------------------------
	if (lngMode == 2) then
		for index, value in pairs(playerArray) do
			if (index ~= curUser) then
				--SendToNick(index, "$To: "..index.." From: "..BotName.." $<"..curUser.."> "..chat)
				VH:SendDataToUser("$To: "..index.." From: "..BotName.." $<"..curUser.."> "..chat, index) -- Verlihub callback
			end
		end
	end
end
-----------------------------------------------------------------------------------------------
function showallrang()
-----------------------------------------------------------------------------------------------
	numar = 0
	exnmr = 0
	for index in pairs(rang) do
		numar = numar + 1
	end
	nmrang = numar
	numar = 0
	SendPMToUser(liniutze3, curUser)
	for index in pairs(rang) do
		exnmr = nmrang - index + 1
		if index ~= 1 then SendPMToUser(liniutze4, curUser) end
		SendPMToUser(index.."\t"..rang[exnmr]..":  \r\n"..liniutze4.." ", curUser)
		for index in pairs(pointArray) do
			if RANG[index] == rang[exnmr] then
				  numar = numar + 1
				  SendPMToUser("\t\t\t"..numar.."\t"..index.." ", curUser)
			end
		end
	end
	SendPMToUser(liniutze3, curUser)
	numar = 0
	exnmr = 0
end
	
-----------------------------------------------------------------------------------------
function TopTenP(alfa) -- top trimis doar unui user
-----------------------------------------------------------------------------------------
	x = 10
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
	end
 	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	if alfa == bestvitdereactie then
		local func = function(a, b) return alfa[a] < alfa[b] end
		table.sort(index, func)
	elseif alfa == vitreArray then
		local func = function(a, b) return alfa[a] < alfa[b] end
		table.sort(index, func)
	else
		local func = function(a, b) return alfa[a] > alfa[b] end
		table.sort(index, func)
	end
	if alfa == pointArray then
		mesajul = "Trivia scores on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointHourArray then 
		mesajul = "Trivia scores last hour on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointDayArray then 
		mesajul = "Trivia scores last day on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointWeekArray then 
		mesajul = "Trivia scores last week on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == bestRun then 
		mesajul = "Trivia runs on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestHourRun then 
		mesajul = "Trivia runs last hour on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestDayRun then 
		mesajul = "Trivia runs last day on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestWeekRun then 
		mesajul = "Trivia runs last week on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == luky then 
		mesajul = "Trivia luky scores on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == PPR then 
		mesajul = "Trivia succes rate on "..numelehubului.."\r\n Pos\t --- % ---\t\t Nick\t\r\n"
	elseif alfa == VMT then 
		mesajul = "Trivia Speed scores on "..numelehubului.."\r\n Pos\t CPS \t\t Nick\t\r\n"
	elseif alfa == duelcastigate then 
		mesajul = "Duel scores on This Hub..\r\n Pos\t victorii \t\t Nick\t\r\n"
	elseif alfa == duelcastigateazi then 
		mesajul = " Today's duels..\r\n Pos\t victorii \t\t Nick\t\r\n"
	elseif alfa == Bvi then 
		mesajul = "Trivia best CPS ..\r\n Pos\t CPS \t\t Nick\t\r\n"
	elseif alfa == bestvitdereactie then 
		mesajul = "Trivia top BestVit.de.Reactie ..\r\n Pos\t sec \t\t Nick \t\r\n"
	elseif alfa == nrintdetinute then 
		mesajul = "Top Number of Questions Answered First ..\r\n Pos\t Nr questions \t\t Nick \t\r\n"
	elseif alfa == pointEternArray then 
		mesajul = "All Time Scores ..\r\n Pos\t Puncte \t\t Nick\t\r\n"
	elseif alfa == runEternArray then 
		mesajul = "All Time Best Run ..\r\n Pos\t Run \t\t Nick\t\r\n"
	elseif alfa == vitreArray then 
		mesajul = "All Time fastest answer..\r\n Pos\t Sec \t\t Nick\t\r\n"
	elseif alfa == vittastArray then 
		mesajul = "All Time Best Speed ..\r\n Pos\t CPS \t\t Nick\t\r\n"
	end
	x = 0
	for index, value in pairs(alfa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if not nrtop then nrtop = 10 end
	if nrtop < x then
		x = nrtop
	else
		if x > 10 then x = 10 end
	end
	local result = "\r\n"..liniutze3.."\r\nTop "..x.." "..mesajul..liniutze3
	if alfa == luky then
		for i = 1, x do
			norocel = string.format("%.2f", alfa[index[i]]/NRIRP[index[i]])
			result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\t Nr.Int.RP: "..NRIRP[index[i]].."  norocel/intrebare ".. norocel.."\r\n"..liniutze4
		end
	elseif alfa == duelcastigate then
		for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i]..mesaje[70]..dueljucate[index[i]].." egaluri "..duelegal[index[i]].."\r\n"..liniutze4 end
	else
		for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\r\n"..liniutze4 end
	end
	msg = result.."\r\n"..liniutze3
	SendGMToUser(msg, curUser)
	x = 10
end
-----------------------------------------------------------------------------------------
function TopTenPP() -- top trimis doar unui user
-----------------------------------------------------------------------------------------
	PT = {} --premii totale
	preemii = { PT, PH, PRH , PSH, PD, PRD, PW, PRW }
	for index, value in pairs(pointArray) do
		user = index
		for index in pairs(preemii) do
			vectordeact = preemii[index]
			if not vectordeact[user] then vectordeact[user] = 0 end
		end
		PT[user] = PH[user] + PRH[user] + PSH[user] + PD[user] + PRD[user] + PW[user] + PRW[user]
	end
	alfa = PT
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
	end
 	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	
	mesajul = " Premii on "..numelehubului.."\r\n Pos\t Nr premii \t\t Nick \t\r\n"
	
	x = 0
	for index, value in pairs(alfa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	local result = "\r\n"..liniutze.."\r\nTop "..x.." "..mesajul.."\r\n"..liniutze.." "

	for i = 1, x do 
		result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t"..index[i].."\t  orare:    -Pt.puncte "..PH[index[i]].."   -Pt.run "..PRH[index[i]].."    -Pt.speed "..PSH[index[i]].."\r\n \t\t  zilnice:    -Pt.puncte "..PD[index[i]].."   -Pt.run "..PRD[index[i]].."\t\t  saptamanale:    -Pt.puncte "..PW[index[i]].." \t -Pt.run "..PRW[index[i]].."\r\n"..liniutze 
	end
	msg = result
	SendPMToUser(msg, curUser)
end
-----------------------------------------------------------------------------------------
function topall(alfa) -- top trimis doar unui user conditonat de nrtir
-----------------------------------------------------------------------------------------
 	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	if alfa == pointArray then
		mesajul = "Trivia scores on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointHourArray then 
		mesajul = "Trivia scores last hour on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointDayArray then 
		mesajul = "Trivia scores last day on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointWeekArray then 
		mesajul = "Trivia scores last week on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == bestRun then 
		mesajul = "Trivia runs on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestHourRun then 
		mesajul = "Trivia runs last hour on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestDayRun then 
		mesajul = "Trivia runs last day on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestWeekRun then 
		mesajul = "Trivia runs last week on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == luky then 
		mesajul = "Trivia luky scores on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == PPR then 
		mesajul = "Trivia Reusita on "..numelehubului.."\r\n Pos\t --- % ---\t\t Nick\t\r\n"
	elseif alfa == VMT then 
		mesajul = "Trivia Speed scores on "..numelehubului.."\r\n Pos\t carcactere/secunda \t\t Nick\t\r\n"
	end
	x= 0
	for index, value in pairs(pointArray) do
		x= x +1
	end
	local result = "\r\n"..liniutze3.."\r\nTop "..x.." "..mesajul.."  "..liniutze4
	for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\r\n"..liniutze4 end
	msg = result.."\r\n"..liniutze3 
	SendPMToUser(msg, curUser)
	alfa = {}
end
-----------------------------------------------------------------------------------------
function TopTenPC(alfa) -- top trimis doar unui user conditonat de nrtir
-----------------------------------------------------------------------------------------
	alfaa = {}
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
		if NRTIR[index] > setare[4] then
			alfaa[index] = tonumber(alfa[index])
		end
	end
 	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfaa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfaa[a] > alfaa[b] end
	table.sort(index, func)
	if alfa == pointArray then
		mesajul = "Trivia scores on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointHourArray then 
		mesajul = "Trivia scores last hour on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointDayArray then 
		mesajul = "Trivia scores last day on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointWeekArray then 
		mesajul = "Trivia scores last week on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == bestRun then 
		mesajul = "Trivia runs on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestHourRun then 
		mesajul = "Trivia runs last hour on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestDayRun then 
		mesajul = "Trivia runs last day on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestWeekRun then 
		mesajul = "Trivia runs last week on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == luky then 
		mesajul = "Trivia luky scores on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == PPR then 
		mesajul = "Trivia Reusita on "..numelehubului.."\r\n Pos\t --- % ---\t\t Nick\t\r\n"
	elseif alfa == VMT then 
		mesajul = "Trivia Speed scores on "..numelehubului.."\r\n Pos\t carcactere/secunda \t\t Nick\t\r\n"
	end
	x = 0
	for index, value in pairs(alfaa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	local result = "\r\n"..liniutze3.."\r\nTop "..x.." "..mesajul.."  "..liniutze3
	for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\t NrT.Int: "..NRTIR[index[i]].."\r\n"..liniutze4 end
	msg = result.."\r\n NrT.Int - numar total de intrebari la care ai primit puncte \r\n"..liniutze3
	SendGMToUser(msg, curUser)
	alfaa = {}
end
-----------------------------------------------------------------------------------------
function TopTen(alfa) -- top trimis tuturor
-----------------------------------------------------------------------------------------
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
		if not RANG[index] then RANG[index] = "Oaspete" end
	end
	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	if alfa == pointArray then
		mesajul = "Trivia scores on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointHourArray then 
		mesajul = "Trivia scores last hour on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointDayArray then 
		mesajul = "Trivia scores last day on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == pointWeekArray then 
		mesajul = "Trivia scores last week on "..numelehubului.."\r\n Pos\t Score\t\t Nick\t\r\n"
	elseif alfa == bestRun then 
		mesajul = "Trivia runs on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestHourRun then 
		mesajul = "Trivia runs last hour on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestDayRun then 
		mesajul = "Trivia runs last day on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == bestWeekRun then 
		mesajul = "Trivia runs last week on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == luky then 
		mesajul = "Trivia luky scores on "..numelehubului.."\r\n Pos\t best_run\t\t Nick\t\r\n"
	elseif alfa == VMTH then 
		mesajul = "Trivia Speed stats on "..numelehubului.." last hour..\r\n Pos\t CPS \t\t Nick\t\r\n"
	elseif alfa == duelcastigateazi then 
		mesajul = "Trivia TOP Zorro..\r\n Pos\t duel won today \t\t Nick\t\r\n"
	end
	x = 0
	for index, value in pairs(alfa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	local result = "\r\n"..liniutze3.."\r\nTop "..x.." "..mesajul.."  "..liniutze3
	for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\t Rang: "..RANG[index[i]].."\r\n"..liniutze4 end
	msg = result
	SendToPlayers(msg)
end
-----------------------------------------------------------------------------------------
function TopFirst(alfa)
-----------------------------------------------------------------------------------------
	x = 10
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
	end
	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	x = 0
	for index, value in pairs(alfa) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	maxim = alfa[index[1]]
	numarator = 0
	for i = 1, x do
		if (alfa[index[i]] == maxim) then
			if (alfa[index[i]]~= 0) then
				primul[i] = index[i]
				numarator = numarator + 1
			end
		end
	end
	numarpremianti = numarator
	punctedate = 0
	for index, value in pairs(alfa) do
		punctedate = punctedate + value
	end
end
-----------------------------------------------------------------------------------------
function TopTenTeam()
-----------------------------------------------------------------------------------------
	numarator = 0
	for index, value in pairs(pointteam) do
		pointteam[index] = tonumber(pointteam[index])
		if pointteam[index] > 0 then
			numarator = numarator + 1
		end
	end
	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(pointteam, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local funct = function(a, b) return pointteam[a] > pointteam[b] end
	table.sort(index, funct)
	
	x = 0
	for index, value in pairs(pointteam) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 9 then x = 9 end
	y = x
	if numarator < y then y = numarator end
	local result = "\r\n "..liniutze3.."\r\nTopTeam "..y.." Trivia scores on "..numelehubului.."\r\n Pos\t Score\t\t Team\t\r\n"..liniutze3
	for i = 1, y do
		result = result.."\r\n "..i..".\t"..pointteam[index[i]].."-puncte \t\t ".. nameteam[index[i]].."\r\n"..liniutze4
	end
	msg = result
	SendToPlayers(msg)
	numarator = 0
end
-----------------------------------------------------------------------------------------
function maximum(alfa) -- retureaza cea mai mare valoare din vectorul alfa si primul[i] numele celui sau celor ce sunt primii, numarul celor ce se afla pe primul loc este dat de numarator
-----------------------------------------------------------------------------------------
	for index, value in pairs(alfa) do
		numarator = numarator + 1
		if numarator == 1 then
			maxim = value
		else 
			if maxim >= value then 
				maxim = maxim
			else
				maxim = value
			end
		end
	end
	numarator = 0
	for index, value in pairs(alfa) do
		punctedate = punctedate + value
		if maxim == value then
			numarator = numarator + 1
			primul[numarator] = index
		end
	end
end
-----------------------------------------------------------------------------------------
function premiere(alfa)
-----------------------------------------------------------------------------------------
	if punctedate == 0 then
		SendToPlayers("Premiere ratata!!!")
	else
		if alfa == pointHourArray then bonus = bonusHour
		elseif alfa == pointDayArray then bonus = bonusDay
		elseif alfa == pointWeekArray then bonus = bonusWeek
		elseif alfa == bestHourRun then bonus = 200
		elseif alfa == bestDayRun then bonus = 800
		elseif alfa == bestWeekRun then bonus = 1200
		elseif alfa == duelcastigateazi then 
			    bonus = 1000
			    SendToPlayers("...:::---ZORRO of the DAY---:::...")
		elseif alfa == VMTH then bonus = 200
		end
		bonus = bonus/numarpremianti
		bonus = string.format("%.1f", bonus)
		for index in pairs(primul) do
			user = primul[index]
			if alfa == pointHourArray then PH[user] = PH[user] + 1
			elseif alfa == pointDayArray then PD[user] = PD[user] + 1
			elseif alfa == pointWeekArray then PW[user] = PW[user] + 1
			elseif alfa == bestHourRun then PRH[user] = PRH[user] + 1
			elseif alfa == bestDayRun then PRD[user] = PRD[user] + 1
			elseif alfa == bestWeekRun then PRW[user] = PRW[user] + 1
			elseif alfa == VMTH then PSH[user] = PSH[user] + 1
			end
			pointArray[user] = pointArray[user] + bonus
			pointHourArray[user] = pointHourArray[user] + bonus
			pointDayArray[user] = pointDayArray[user] + bonus
			pointWeekArray[user] = pointWeekArray[user] + bonus
			SendToPlayers(user ..mesaje[99]..bonus..mesaje[100]..pointArray[user])
			if teamArray[user] ~= 0 then
			for index, value in pairs(nameteam) do
				if teamArray[user] == index then
					pointteam[index] = pointteam[index] + bonus
					SendToPlayers(mesaje[101]..nameteam[index]..mesaje[102]..pointteam[index]..mesaje[81])
				end
			end
			end
		end
	end
	primul = {}
	punctedate = 0
	bonus = 0
	numarpremianti = 0
end
-----------------------------------------------------------------------------------------
function Verificare()
-----------------------------------------------------------------------------------------
	if ac == 0 then
		ver = 1
		aw[curUser] = 1
	end
	if ac ~= 0 then
		if (not (aw[curUser])) then
			ver = 1
			aw[curUser] = 1
		else 
			SendToPlayers(curUser..mesaje[103])
			ver = 0
			nickeliminat = curUser
			validareuser[nickeliminat] = 1
			SendToPlayers(curUser..mesaje[104])
		end
	end
end
-----------------------------------------------------------------------------------------
function Duel()
-----------------------------------------------------------------------------------------
	if (modulduel == 1) then
		nrast = tonumber(nrast + 1)
		if (nrast == 3) then
			modulduel = 0
			SendToPlayers(mesaje[105])
			nrast = 0
			modulavantajduel = 0
		end
	end
	if (modulduel == 3) then
		contorduel = contorduel + 1
		validareq = tonumber(0) -- validareq valideaza raspunsul doar primului refuzand celor care raspund dupa :)
		if not intrebari2 then
			intrebari2 = tonumber(0)
		end
		if curUsera == duelist1 then
			intrebari1 = intrebari1 + 1
			validareq = validareq + 1
		end
		if curUsera == duelist2 then
			intrebari2 = intrebari2 + 1
			validareq = validareq + 1
		end
		if tipduel == 3 then
			if curUsera == duelist3 then
				intrebari1 = intrebari1 + 1
				validareq = validareq + 1
			end
			if curUsera == duelist4 then
				intrebari2 = intrebari2 + 1
				validareq = validareq + 1
			end
		end
		if not winner[2] then
			blablala = 1
		else
			if winner[2] == duelist1 and validareq == 0 then
				intrebari1 = intrebari1 + 1
				validareq = validareq + 1
			end
			if winner[2] == duelist2 and validareq == 0 then
				intrebari2 = intrebari2 + 1
				validareq = validareq + 1
			end
			if tipduel == 3 then
				if winner[2] == duelist3 and validareq == 0 then
					intrebari1 = intrebari1 + 1
					validareq = validareq + 1
				end
				if winner[2] == duelist4 and validareq == 0 then
					intrebari2 = intrebari2 + 1
					validareq = validareq + 1
				end
			end
		end
		if not winner[3] then
			blablala = 1
		else
			if winner[3] == duelist1 and validareq == 0 then
				intrebari1 = intrebari1 + 1
				validareq = validareq + 1
			end
			if winner[3] == duelist2 and validareq == 0 then
				intrebari2 = intrebari2 + 1
				validareq = validareq + 1
			end
			if tipduel == 3 then
				if winner[3] == duelist3 and validareq == 0 then
					intrebari1 = intrebari1 + 1
					validareq = validareq + 1
				end
				if winner[3] == duelist4 and validareq == 0 then
					intrebari2 = intrebari2 + 1
					validareq = validareq + 1
				end
			end			
		end
		if (contorduel == setare[6]) then
			boolpremiereduel = 1
			SendToPlayers(mesaje[106]..echipa1.." "..intrebari1.."  -  "..echipa2.." "..intrebari2)
		else
			SendToPlayers(mesaje[107]..contorduel..mesaje[108]..echipa1.." "..intrebari1.."  -  "..echipa2.." "..intrebari2)
		end
	end
	if (modulduel == 2) then
		if tipduel ~= 3 then
			echipa1 = duelist1
			echipa2 = duelist2
		else
			echipa1 = duelist1.." & "..duelist3
			echipa2 = duelist2.." & "..duelist4
		end
		SendToPlayers(mesaje[109]..echipa1..mesaje[110]..echipa2.." -----START!!!")
		Nrdueluri = 0
		Nrvictorii1 = 0
		Nrvictorii2 = 0
		Nregaluri = 0
		if tipduel ~= 3 then
		local handle = io.open(strTrivDuelFile, "r")
		if (handle) then
			local line = handle:read()
			while line do
				local arrTmp = tokenize(line, strGSep)
				if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
					if ((arrTmp[1] == duelist1) and (arrTmp[2] == duelist2)) then
						Nrdueluri = Nrdueluri + 1
						pct2 = tonumber(arrTmp[4])
						pct1 = tonumber(arrTmp[3])
						if pct1 > pct2 then Nrvictorii1 = Nrvictorii1 + 1
						elseif pct1 < pct2 then Nrvictorii2 = Nrvictorii2 + 1
						elseif pct1 == pct2 then Nregaluri = Nregaluri + 1
						end
					end
					if ((arrTmp[1] == duelist2) and (arrTmp[2] == duelist1)) then
						Nrdueluri = Nrdueluri + 1
						pct1 = tonumber(arrTmp[4])
						pct2 = tonumber(arrTmp[3])
						if pct1 > pct2 then Nrvictorii1 = Nrvictorii1 + 1
						elseif pct1 < pct2 then Nrvictorii2 = Nrvictorii2 + 1
						elseif pct1 == pct2 then Nregaluri = Nregaluri + 1
						end
					end
				end
				line = handle:read()
			end
		 handle:close()
		end
		SendToPlayers(mesaje[111]..Nrvictorii1..mesaje[112]..duelist1.." --- "..Nrvictorii2..mesaje[112]..duelist2.." ")
		--SendToPlayers("-Victorii "..duelist2.." - "..Nrvictorii2.." ")
		SendToPlayers(mesaje[113]..Nregaluri.." ")
		end
		Nrdueluri = 0
		Nrvictorii1 = 0
		Nrvictorii2 = 0
		Nregaluri = 0
		contorduel = tonumber(0)
		intrebari1 = tonumber(0)
		--intrebari2 = tonumber(0)
		modulduel = tonumber(3)
	end
	if tipduel ~= 3 then
		premiereduel12()
	else
		premiereduel3()
	end
end
function premiereduel3()
	if boolpremiereduel == 1 then
		if contorduel > setare[6] then
		bonusduel = setare[7]
		if intrebari1 > intrebari2 then
			pierdut = (intrebari1 - intrebari2)*10
			bonusduel = bonusduel + (intrebari1 - intrebari2)*10
			pierdut = pierdut / 2
			bonusduel = bonusduel / 2
			pointArray[duelist1] = pointArray[duelist1] + bonusduel
			pointArray[duelist2] = pointArray[duelist2] - pierdut
			pointArray[duelist3] = pointArray[duelist3] + bonusduel
			pointArray[duelist4] = pointArray[duelist4] - pierdut
			if not teamArray[duelist1] then
				blabla = 1
			else
				pointiniteam[duelist1] = pointiniteam[duelist1] + bonusduel
			end
			if not teamArray[duelist2] then
				blabla = 1
			else
				pointiniteam[duelist2] = pointiniteam[duelist2] - pierdut
			end
			if not teamArray[duelist3] then
				blabla = 1
			else
				pointiniteam[duelist3] = pointiniteam[duelist3] + bonusduel
			end
			if not teamArray[duelist4] then
				blabla = 1
			else
				pointiniteam[duelist4] = pointiniteam[duelist4] - pierdut
			end
			SendToPlayers(mesaje[114]..echipa1..mesaje[115]..intrebari1.." - "..intrebari2)
			SendToPlayers(duelist1..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist1])
			SendToPlayers(duelist3..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist3])
			SendToPlayers(duelist2..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist2])
			SendToPlayers(duelist4..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist4])
		elseif intrebari1 < intrebari2 then
			pierdut = (intrebari2 - intrebari1)*10
			bonusduel = bonusduel + (intrebari2 - intrebari1)*10
			pierdut = pierdut / 2
			bonusduel = bonusduel / 2
			pointArray[duelist2] = pointArray[duelist2] + bonusduel
			pointArray[duelist1] = pointArray[duelist1] - pierdut
			pointArray[duelist4] = pointArray[duelist4] + bonusduel
			pointArray[duelist3] = pointArray[duelist3] - pierdut
			if not teamArray[duelist2] then
				blabla = 1
			else
				pointiniteam[duelist2] = pointiniteam[duelist2] + bonusduel
			end
			if not teamArray[duelist1] then
				blabla = 1
			else
				pointiniteam[duelist1] = pointiniteam[duelist1] - pierdut
			end
			if not teamArray[duelist4] then
				blabla = 1
			else
				pointiniteam[duelist4] = pointiniteam[duelist4] + bonusduel
			end
			if not teamArray[duelist3] then
				blabla = 1
			else
				pointiniteam[duelist3] = pointiniteam[duelist3] - pierdut
			end		
			SendToPlayers(mesaje[114]..echipa2..mesaje[115]..intrebari2.." - "..intrebari1)
			SendToPlayers(duelist2..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist2])
			SendToPlayers(duelist4..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist4])
			SendToPlayers(duelist1..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist1])
			SendToPlayers(duelist3..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist3])
		elseif intrebari1 == intrebari2 then
			SendToPlayers(mesaje[119]..intrebari1.." - "..intrebari2)
		end
		tinta = nil		
		duelist1 = nil
		duelist2 = nil
		duelist3 = nil
		duelist4 = nil
		modulduel = 0
		intrebari1 = 0
		intrebari2 = 0
		pierdut = 0
		existacoleg = 0
		boolpremiereduel = 0
		contorduel = 0
		miza = 0
		modulavantajduel = 0
		bonusduel = setare[7]
		end
	end
end
function premiereduel12()
	if boolpremiereduel == 1 then
		if contorduel > setare[6] then
		bonusduel = setare[7]
		if intrebari1 > intrebari2 then
			pierdut = (intrebari1 - intrebari2)*10
			bonusduel = bonusduel + (intrebari1 - intrebari2)*10
			if tipduel == 2 then
				bonusduel = bonusduel + miza
				pierdut = pierdut + miza
				if miza ~= 0 then
				if not duelcumizaazi[duelist1] then duelcumizaazi[duelist1] = 0 end
				duelcumizaazi[duelist1] = duelcumizaazi[duelist1] + 1
				end			
			end
			pointArray[duelist1] = pointArray[duelist1] + bonusduel
			pointArray[duelist2] = pointArray[duelist2] - pierdut
			if not teamArray[duelist1] then
				blabla = 1
			else
				pointiniteam[duelist1] = pointiniteam[duelist1] + bonusduel
			end
			if not teamArray[duelist2] then
				blabla = 1
			else
				pointiniteam[duelist2] = pointiniteam[duelist2] - pierdut
			end
			if not duelcastigate[duelist1] then
				duelcastigate[duelist1] = 1
			else
				duelcastigate[duelist1] = duelcastigate[duelist1] + 1
			end
			if not duelcastigateazi[duelist1] then
				duelcastigateazi[duelist1] = 1
			else
				duelcastigateazi[duelist1] = duelcastigateazi[duelist1] + 1
			end
			if not duelpierdute[duelist2] then
				duelpierdute[duelist2] = 1
			else
				duelpierdute[duelist2] = duelpierdute[duelist2] + 1
			end
			SendToPlayers(mesaje[114]..duelist1..mesaje[115]..intrebari1.." - "..intrebari2)
			SendToPlayers(duelist1..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist1])
			SendToPlayers(duelist2..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist2])
		elseif intrebari1 < intrebari2 then
			pierdut = (intrebari2 - intrebari1)*10
			bonusduel = bonusduel + (intrebari2 - intrebari1)*10
			if tipduel == 2 then
				bonusduel = bonusduel + miza
				pierdut = pierdut + miza
				if miza ~= 0 then
				if not duelcumizaazi[duelist2] then duelcumizaazi[duelist2] = 0 end
				duelcumizaazi[duelist2] = duelcumizaazi[duelist2] + 1
				end
			end
			pointArray[duelist2] = pointArray[duelist2] + bonusduel
			pointArray[duelist1] = pointArray[duelist1] - pierdut
			if not teamArray[duelist2] then
				blabla = 1
			else
				pointiniteam[duelist2] = pointiniteam[duelist2] + bonusduel
			end
			if not teamArray[duelist1] then
				blabla = 1
			else
				pointiniteam[duelist1] = pointiniteam[duelist1] - pierdut
			end
			if not duelcastigate[duelist2] then
				duelcastigate[duelist2] = 1
			else
				duelcastigate[duelist2] = duelcastigate[duelist2] + 1
			end
			if not duelcastigateazi[duelist2] then
				duelcastigateazi[duelist2] = 1
			else
				duelcastigateazi[duelist2] = duelcastigateazi[duelist2] + 1
			end
			if not duelpierdute[duelist1] then
				duelpierdute[duelist1] = 1
			else
				duelpierdute[duelist1] = duelpierdute[duelist1] + 1
			end			
			SendToPlayers(mesaje[114]..duelist2..mesaje[115]..intrebari2.." - "..intrebari1)
			SendToPlayers(duelist2..mesaje[116]..bonusduel..mesaje[117]..pointArray[duelist2])
			SendToPlayers(duelist1..mesaje[118]..pierdut..mesaje[117]..pointArray[duelist1])
		elseif intrebari1 == intrebari2 then
			if not duelegal[duelist2] then
				duelegal[duelist2] = 1
			else
				duelegal[duelist2] = duelegal[duelist2] + 1
			end
			if not duelegal[duelist1] then
				duelegal[duelist1] = 1
			else
				duelegal[duelist1] = duelegal[duelist1] + 1
			end
			SendToPlayers(mesaje[119]..intrebari1.." - "..intrebari2)
		end
		local handle = io.open(strTrivDuelFile, "a")
		handle:write(duelist1..strGSep..duelist2..strGSep..intrebari1..strGSep..intrebari2.."\r\n")
		handle:close()
		if not teamArray[duelist2] then
			blabla = 1
			else
			local handle = io.open(strteamFile, "w")
			for index, value in pairs(teamArray) do
				handle:write(index..strGSep..value..strGSep..pointiniteam[index].."\r\n")
			end
			handle:close()
		end
		if not teamArray[duelist1] then
			blabla = 1
			else
			local handle = io.open(strteamFile, "w")
			for index, value in pairs(teamArray) do
				handle:write(index..strGSep..value..strGSep..pointiniteam[index].."\r\n")
			end
			handle:close()
		end
		if not dueljucate[duelist1] then
			dueljucate[duelist1] = 1
		else
			dueljucate[duelist1] = dueljucate[duelist1] + 1
		end
		if not dueljucate[duelist2] then
			dueljucate[duelist2] = 1
		else
			dueljucate[duelist2] = dueljucate[duelist2] + 1
		end		
		local handle = io.open(strTrivScorDuelFile, "w")
		for index, value in pairs(dueljucate) do
			if not duelcastigate[index] then duelcastigate[index] = 0 end
			if not duelcastigateazi[index] then duelcastigateazi[index] = 0 end
			if not duelpierdute[index] then duelpierdute[index] = 0 end
			if not duelegal[index] then duelegal[index] = 0 end
			handle:write(index..strGSep..value..strGSep..duelcastigate[index]..strGSep..duelpierdute[index]..strGSep..duelegal[index]..strGSep..duelcastigateazi[index].."\r\n")
		end
		handle:close()
		tinta = nil		
		duelist1 = nil
		duelist2 = nil
		modulduel = 0
		intrebari1 = 0
		intrebari2 = 0
		pierdut = 0
		contordduel = 0
		boolpremiereduel = 0
		contorduel = 0
		miza = 0
		modulavantajduel = 0
		bonusduel = setare[7]
		end
	end
end
--------------------------------------------------------------------------------
function addteam()
--------------------------------------------------------------------------------
	if nr < 10 then
	if nameteam[nr] == 0 or nameteam[nr] == "0" then
	local handle = io.open(strTrivTeamNameFile, "w")
	for index, value in pairs(nameteam) do
		tn = tonumber(value)
		if index == nr then
			if tn ~= nil then
				SendToPlayers(value.."...."..index.." tn "..tn)
				nameteam[index] = nume
				SendToPlayers(mesaje[101]..nameteam[index].."..."..index.."  a fost creata  ")
			else SendToPlayers("Eroare echipa cu numarul "..index.." exista deja \r\n\t\t\t\t\t tasteaza #showteam pentru a corecta problema")
			end
		end
	end
	handle:write(nameteam[1]..strGSep..nameteam[2]..strGSep..nameteam[3]..strGSep..nameteam[4]..strGSep..nameteam[5]..strGSep..nameteam[6]..strGSep..nameteam[7]..strGSep..nameteam[8]..strGSep..nameteam[9])
	handle:close()
	else SendToPlayers("Error Echipa nr "..nr.." exista.")
	end
	else SendToPlayers("Eroare numarul maxim de echipe este  10")
	end
end
function savenameteam()
	local handle = io.open(strTrivTeamNameFile, "w")
	handle:write(nameteam[1]..strGSep..nameteam[2]..strGSep..nameteam[3]..strGSep..nameteam[4]..strGSep..nameteam[5]..strGSep..nameteam[6]..strGSep..nameteam[7]..strGSep..nameteam[8]..strGSep..nameteam[9])
	handle:close()
end
-----------------------------------------------------------------------------------------
function LoadScoresTeam(curTeam)
-----------------------------------------------------------------------------------------
	local handle = io.open(strTrivTeamScoreFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				pointteam[1] = arrTmp[1]
				pointteam[2] = arrTmp[2]
				pointteam[3] = arrTmp[3]
				pointteam[4] = arrTmp[4]
				pointteam[5] = arrTmp[5]
				pointteam[6] = arrTmp[6]
				pointteam[7] = arrTmp[7]
				pointteam[8] = arrTmp[8]
				pointteam[9] = arrTmp[9]
			end
			line = handle:read()
		end
		handle:close()
		--if curUser ~= nil then SendGMToUser("Scores Loaded") end
	end
	local handle = io.open(strTrivTeamNameFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				nameteam[1] = arrTmp[1]
				nameteam[2] = arrTmp[2]
				nameteam[3] = arrTmp[3]
				nameteam[4] = arrTmp[4]
				nameteam[5] = arrTmp[5]
				nameteam[6] = arrTmp[6]
				nameteam[7] = arrTmp[7]
				nameteam[8] = arrTmp[8]
				nameteam[9] = arrTmp[9]
			end
			line = handle:read()
		end
		handle:close()
	end
	local handle = io.open(strteamFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				teamArray[arrTmp[1]] = tonumber(arrTmp[2])
				pointiniteam[arrTmp[1]] = tonumber(arrTmp[3])
			end
			line = handle:read()
		end
		handle:close()
	end
end
-----------------------------------------------------------------------------------------
function AddMember(member,nrechipa)
-----------------------------------------------------------------------------------------
	numarator = 0
	nrechipa = tonumber(nrechipa)
	if not teamArray[member] then
		if nrechipa <= 9 then
			for index in pairs(teamArray) do
				if teamArray[index] == nrechipa then
					numarator = numarator + 1
				end
			end
			SendToPlayers(" Echipa "..nrechipa.." are "..numarator.." membri")
			if numarator <= (setare[8] - 1) then
				if not (pointArray[member]) then
					pointArray[member] = 0
				end
				pointiniteam[member] = pointArray[member]
				teamArray[member] = tonumber(nrechipa)
				SendToPlayers(member.." a devenit membru al echipei "..nrechipa)
				local handle = io.open(strteamFile, "a")
				handle:write(member..strGSep..teamArray[member]..strGSep..pointiniteam[member].."\r\n")
				handle:close()
			else
				SendToPlayers(" Echipa - "..nrechipa.." are   deja numarul maxim de jucatori")
			end
		else
			SendToPlayers(" Error, numarul maxim de exhipe este 9")
		end
	else
		SendToPlayers(member.." Este deja membru al unei echipe")
	end
end
function leaveteam()
	if not teamArray[curUser] then
		SendToPlayers(curUser.." nu esti membru al unei echipe deci nush pe cine vrei sa parasesti ")
	else
		teamArray[curUser] = nil
		pointiniteam[curUser] = nil
		SendToPlayers(curUser.." nu mai esti membru al vreunei echipe ")
	end
	local handle = io.open(strteamFile, "w")
	for index, value in pairs(teamArray) do
		if not value then
			valoareaiurearau = 124547
		else
			handle:write(index..strGSep..teamArray[index]..strGSep..pointiniteam[index].."\r\n")
		end
	end
	handle:close()
end
function delmember(member)
	if not teamArray[member] then
		SendToPlayers(member.." nu este membru al unei echipe ")
	else
		teamArray[member] = nil
		pointiniteam[member] = nil
		SendToPlayers(member.." nu mai esti membru al vreunei echipe ")
	end
	local handle = io.open(strteamFile, "w")
	for index, value in pairs(teamArray) do
		if not value then
			valoareaiurearau = 124547
		else
			handle:write(index..strGSep..teamArray[index]..strGSep..pointiniteam[index].."\r\n")
		end
	end
	handle:close()
end
-----------------------------------------------------------------------------------------
function PointTeam()
-----------------------------------------------------------------------------------------
	if ac < 4 then
	for index, value in pairs(nameteam) do
		if teamArray[curUser] == index then
			point = string.format("%.1f", pointArray[curUser]-pointiniteam[curUser])
			pointteam[index] = pointteam[index] + tsc
			SendToPlayers(mesaje[101]..nameteam[index]..mesaje[102]..pointteam[index]..mesaje[120]..point..mesaje[121]..curUser)
		end
	end
	if not (teamArray[winner[1]]) then
		nittt = 1
	else
		if (teamArray[winner[1]] == teamArray[winner[2]]) and (teamArray[winner[1]] == teamArray[winner[3]]) then
			index = tonumber(teamArray[winner[1]])
			if not booldescurcate then 
				bonuslinie = 100
			else
				bonuslinie = 200
			end
			pointteam[index] = pointteam[index] + bonuslinie
			SendToPlayers(mesaje[101]..nameteam[index]..mesaje[122]..bonuslinie..mesaje[123]..pointteam[index].."pct.")
			index = nil
		end
	end
	end
end
-----------------------------------------------------------------------------------------
function ShowMeTeam()
-----------------------------------------------------------------------------------------
	numarator = 0
	membriiechipei = {}
	punctemembrii = {}
	invers = {}
	if not (teamArray[curUser]) then
		SendToPlayers(curUser.." nu esti membru al vreunei echipe")
	else
		SendToPlayers("Membri Echipei tale sunt:")
		for index, value in pairs(teamArray) do
			if teamArray[curUser] == teamArray[index] then
				numarator = numarator + 1
				membriiechipei[numarator] = index
				--SendToPlayers(numarator.."_"..index)
			end
		end
	end
	for index, value in pairs(membriiechipei) do
		punctemembrii[value] = tonumber(pointArray[value] - pointiniteam[value])
	end	
	numarator = 0
	alfa = punctemembrii
	for index, value in pairs(alfa) do
		alfa[index] = tonumber(alfa[index])
		if not RANG[index] then RANG[index] = "Oaspete" end
	end
	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(alfa, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local func = function(a, b) return alfa[a] > alfa[b] end
	table.sort(index, func)
	mesajul = "\r\n"..liniutze2.." \r\n Puncte pentru echipa _ _ _ Nick _ _ Rang \r\n "..liniutze2.."\r\n"
	x = 0
	for index, value in pairs(alfa) do
	      x = x + 1
	end
	local result = mesajul.."  "
	for i = 1, x do result = result.."\r\n "..i..".\t"..alfa[index[i]].."\t\t"..index[i].."\t\t Rang: "..RANG[index[i]] end
	msg = result.."\r\n"..liniutze2.."\r\n"
	SendToPlayers(msg)

	numarator = 0
	membriiechipei = {}
	punctemembrii = {}
	invers = {}
end
-----------------------------------------------------------------------------------------
function ShowTeams()
-----------------------------------------------------------------------------------------
	numaratorr= 0
	for index, value in pairs(nameteam) do
		numaratorr = index
		if nameteam[index] == 0 then 
			SendGMToUser(" Echipa - "..index.." nu exista inca",curUser)
		else
		SendGMToUser("         "..index.." Echipa - "..nameteam[index].." :",curUser)
		numarator = 0
		for index, value in pairs(teamArray) do
			if numaratorr == teamArray[index] then
				numarator = numarator + 1
				SendGMToUser(numarator.."_"..index,curUser)
			end
		end
		end
	end
	numarator = 0
	numaratorr = 0
end
-----------------------------------------------------------------------------------------
function SnowTeam()
-----------------------------------------------------------------------------------------
	for index, value in pairs(nameteam) do
		SendToPlayers(index.."...."..value.."........"..pointteam[index].." puncte")
	end
end
-----------------------------------------------------------------------------------------
function Iniwinner()
-----------------------------------------------------------------------------------------
	winner[ac] = curUser
end
-----------------------------------------------------------------------------------------
function Maximum(vector) --this function return maxim value Maxim 
-----------------------------------------------------------------------------------------
	for index in pairs(vector) do
		numarator = numarator +1
		if numarator == 1 then
			Maxim = tonumber(vector[1])
		else
			if Maxim > vector[numarator] then
				Maxim = tonumber(maxim)
			else
				Maxim = tonumber(vector[numarator])
			end
		end
	end
end
-----------------------------------------------------------------------------------------
function showteam(omega)
-----------------------------------------------------------------------------------------
	pointteamx = {}
	pointteamx = {0 , 0, 0, 0, 0, 0, 0, 0, 0}
	for index in pairs(omega) do
		if teamArray[index] == 1 then pointteamx[1] = pointteamx[1] + omega[index]
		elseif teamArray[index] == 2 then pointteamx[2] = pointteamx[2] + omega[index]
		elseif teamArray[index] == 3 then pointteamx[3] = pointteamx[3] + omega[index]
		elseif teamArray[index] == 4 then pointteamx[4] = pointteamx[4] + omega[index]
		elseif teamArray[index] == 5 then pointteamx[5] = pointteamx[5] + omega[index]
		elseif teamArray[index] == 6 then pointteamx[6] = pointteamx[6] + omega[index]
		elseif teamArray[index] == 7 then pointteamx[7] = pointteamx[7] + omega[index]
		elseif teamArray[index] == 8 then pointteamx[8] = pointteamx[8] + omega[index]
		elseif teamArray[index] == 9 then pointteamx[9] = pointteamx[9] + omega[index]
		end
	end
	for index, value in pairs(pointteamx) do
		pointteamx[index] = tonumber(pointteamx[index])
	end
	local index = {n=0}
	--table.foreach(pointArray, function(nick, score) table.insert(%index, nick) end)
	table.foreach(pointteamx, function(nick, score) table.insert(index, nick) end)
	--local func = function(a, b) return %pointArray[a] > %pointArray[b] end
	local funct = function(a, b) return pointteamx[a] > pointteamx[b] end
	table.sort(index, funct)
	
	x = 0
	for index, value in pairs(pointteamx) do
	    if value ~= 0 then
	      x = x + 1
	    end
	end
	if x > 10 then x = 10 end
	y = x
	local result = "\r\nTopTeam "..y.." Trivia scores in Eden-Pasional..\r\n Pos\t Team\t\t Score\t\r\n"
	for i = 1, y do result = result.."\r\n "..i..".\t"..nameteam[index[i]].."\t\t".. pointteamx[index[i]] end
	msg = result
	SendToPlayers(msg)
	pointteamx = {0 , 0, 0, 0, 0, 0, 0, 0, 0}
end
-----------------------------------------------------------------------------------------
function SendMesajToUseri()
-----------------------------------------------------------------------------------------
	SendToPlayers(" \n                ------------------------------------------------------------ \n \n                Un zambet O floare O raza de soare tuturor fetelor cu multumiri pentru fiecare secunda in care ne colorati viata!. \n \n                 ------------------------------------------------------------ ")
end
-----------------------------------------------------------------------------------------
function Restartall()
-----------------------------------------------------------------------------------------
	SendToPlayers("- TriviaBot restarted.")
	--SendToPlayers("If Save is used now it will overwrite the old save!")
-------------------------------------------------------toate valorile initiale reduse la zero
	for index, value in pairs(pointArray) do
		player = index
		for index, value in pairs(iniVector) do
			if not value[player] then
				value[player] = 0
			else
				value[player] = 0
			end
		end
	end
---------------------------------------------------
	PH = {} -- premii orare dupa scor
	PRH = {} -- premii orare dupa run
	PSH = {} --premiu orar speed
	PD = {} -- premii silnice dupa scor
	PRD = {} -- premii zilnice dupa run
	PW = {} -- premii saptamanale dupa scor
	PRW = {} -- premii saptamanale dupa run
	NRTIR = {} --numar total de intrebari raspunse
	NRIRP = {} -- numar intrebari raspunse primul
	NRCT = {} -- numar caractere tastate
	TTR = {} -- timp total de raspuns
	TMR = {} --Timp mediu de raspuns TTR/NRTIR
	VMT = {} -- viteza medie de raspuns NRCT/TTR
	PPR = {} --procent de raspuns primul NRIRP*100/NRTIR
	NRTIRH = {} --numar total de intrebari raspunse
	NRIRPH = {} -- numar intrebari raspunse primul
	NRCTH = {} -- numar caractere tastate
	TTRH = {} -- timp total de raspuns
	TMRH = {} --Timp mediu de raspuns TTR/NRTIR
	VMTH = {} -- viteza medie de tastat NCR/TTR
	PPRH = {} --procent de raspuns primul NRIRP*100/NRTIR
	RANG = {}
	pointArray = {}
	pointHourArray = {}
	pointDayArray = {}
	pointWeekArray = {}
	bestRun = {}
	bestHourRun = {}
	bestDayRun = {}
	bestWeekRun = {}
	pointiniteam = {}
	duelcastigateazi = {}
	luky = {}
	teamArray = {}
	bestvitdereactie = {}
	Bvi = {}
	if modreset == 1 then
		stareQ = {}
		recordintrebare = {}
		recordman = {}
		local handle = io.open(strTrivstareqFile, "w")
		handle:write()
		handle:close()
		local handle = io.open(strDefTrivSpeed2File, "w")
		handle:write()
		handle:close()
		SendToPlayers("- The Statistics were reset!")
	end
	if boolresetetern == 1 then
		pointEternArray = {}
		runEternArray = {}
		vittastArray = {}
		vitreArray = {}
		local handle = io.open(strTrivScoreEternFile, "w")
		handle:write()
		handle:close()
		SendToPlayers("- Eternal Top is reset!")
		boolresetetern = 0
			if modreset == 0 then
				stareQ = {}
				recordintrebare = {}
				recordman = {}
				local handle = io.open(strTrivstareqFile, "w")
				handle:write()
				handle:close()
				local handle = io.open(strDefTrivSpeed2File, "w")
				handle:write()
				handle:close()
				SendToPlayers("- The Statistics were reset!")
			end
	end
	if boolresetduel == 1 then
		dueljucate = {}
		duelcastigate = {}
		duelpierdute = {}
		duelegal = {}
		duelcastigateazi = {}
		local handle = io.open(strTrivDuelFile, "w")
		handle:write()
		handle:close()
		local handle = io.open(strTrivScorDuelFile, "w")
		handle:write()
		handle:close()
		SendToPlayers("- The Duels were reset!")
		boolresetduel = 0
	end
	local handle = io.open(strTrivScorDuelFile, "w")
	for index, value in pairs(dueljucate) do
		if not duelcastigate[index] then duelcastigate[index] = 0 end
		if not duelcastigateazi[index] then duelcastigateazi[index] = 0 end
		if not duelpierdute[index] then duelpierdute[index] = 0 end
		if not duelegal[index] then duelegal[index] = 0 end
		handle:write(index..strGSep..value..strGSep..duelcastigate[index]..strGSep..duelpierdute[index]..strGSep..duelegal[index]..strGSep..duelcastigateazi[index].."\r\n")
		handle:close()
	end
	local handle = io.open(strteamFile, "w")
	handle:write("")
	handle:close()
	pointteam = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	nameteam = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	local handle = io.open(strTrivTeamScoreFile, "w")
	handle:write(pointteam[1]..strGSep..pointteam[2]..strGSep..pointteam[3]..strGSep..pointteam[4]..strGSep..pointteam[5]..strGSep..pointteam[6]..strGSep..pointteam[7]..strGSep..pointteam[8]..strGSep..pointteam[9])
	handle:close()
	local handle = io.open(strTrivTeamNameFile, "w")
	handle:write(nameteam[1]..strGSep..nameteam[2]..strGSep..nameteam[3]..strGSep..nameteam[4]..strGSep..nameteam[5]..strGSep..nameteam[6]..strGSep..nameteam[7]..strGSep..nameteam[8]..strGSep..nameteam[9])
	handle:close()
	SaveScores()
	LoadQuestions()
	LoadScores()
	loadmarimi()
	LoadIniTime()
	LoadScoresTeam()
	SendGMToAll(BotName, strStopp)
	SendToPlayers(" \r\n            ------------------------------------------  \r\n ------- Take necessary !replug lua ------- \r\n            ------------------------------------------")
end
-----------------------------------------------------------------------------------------
function initiereparametrii()
-----------------------------------------------------------------------------------------
	for index, value in pairs(pointArray) do
		player = index
		for index, value in pairs(iniVector) do
			if not value[player] then
				value[player] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------
function informatii()
-----------------------------------------------------------------------------------------
	NRTIR[curUser] = NRTIR[curUser] + 1
	if ac == 1 then
		NRIRP[curUser] = NRIRP[curUser] + 1
	end
	NRCT[curUser] = NRCT[curUser] + lsc
	TTR[curUser] = TTR[curUser] + traspuns
	if TTR[curUser] ~= 0 then
		VMT[curUser] = (NRCT[curUser])/(TTR[curUser])
		VMT[curUser] = string.format("%.2f", VMT[curUser])
	end
	TMR[curUser] = string.format("%.2f",(TTR[curUser])/(NRTIR[curUser]))
	PPR[curUser] = string.format("%.2f",(NRIRP[curUser]*100)/(NRTIR[curUser]))
	--PENTRU ORA
	NRTIRH[curUser] = NRTIRH[curUser] + 1
	if ac == 1 then
		NRIRPH[curUser] = NRIRPH[curUser] + 1
	end
	NRCTH[curUser] = NRCTH[curUser] + lsc
	TTRH[curUser] = TTRH[curUser] + traspuns
	if TTRH[curUser] ~= 0 then
		VMTH[curUser] = string.format("%.2f",(NRCTH[curUser])/(TTRH[curUser]))
	end
	TMRH[curUser] = string.format("%.1f",(TTRH[curUser])/(NRTIRH[curUser]))
	PPRH[curUser] = string.format("%.1f",(NRIRPH[curUser]*100)/(NRTIRH[curUser]))
end
-----------------------------------------------------------------------------------------
function sentinfo()
-----------------------------------------------------------------------------------------
	if modsi == 1 then
		playerAfi = curUser
	else
		playerAfi = playercerut
	end
	SendGMToUser(modsi,curUser)
	marimiafisate = { RANG[playerAfi], NRTIR[playerAfi], NRIRP[playerAfi], TMR[playerAfi], VMT[playerAfi], PPR[playerAfi] }
	numarator = tonumber(0)
	for index in pairs(marimiafisate) do
		if not index then
			numarator = numarator + 1
		end
	end
	if not pointArray[playerAfi] or numarator ~= 0 then
		  SendGMToUser(" Nu ai jucat inca, dupa ce vei da un raspuns vei primii si informatii", playerAfi)
	else
		if not dueljucate[playerAfi] then
			dueljucate[playerAfi] = 0
		end
		if not duelcastigate[playerAfi] then
			duelcastigate[playerAfi] = 0
		end
		if not duelpierdute[playerAfi] then
			duelpierdute[playerAfi] = 0
		end
		if not duelegal[playerAfi] then
			duelegal[playerAfi] = 0
		end
		nrqu = 0
		for index, value in pairs(recordman) do
			if recordman[index] == playerAfi then
				nrqu = nrqu + 1
			end
		end
		  SendGMToUser("\r\n - Hi! \r\n - Rank - "..RANG[playerAfi].."\r\n - Number of questions answered: "..NRTIR[playerAfi].."  \r\n - Number of questions answered first (current month): "..NRIRP[playerAfi].." \r\n - Average time to answer: "..TMR[playerAfi].." sec \r\n - Average typing speed: "..VMT[playerAfi].." CPS \r\n - Success rate "..PPR[playerAfi].." % \r\n - Fastest typing speed: "..Bvi[playerAfi].." CPS \r\n - Number of questions answered first (all time): "..nrqu.."\r\n - Fastest answer: "..bestvitdereactie[playerAfi].."\r\n - Personal duels \r\n - Number of duels: "..dueljucate[playerAfi].."\r\n  - "..duelcastigate[playerAfi].." won, "..duelegal[playerAfi].." tied, "..duelpierdute[playerAfi].." lost ", curUser)
	end
	modsi = nil
	playercerut = nil
end
-----------------------------------------------------------------------------------------
function inirangul()
-----------------------------------------------------------------------------------------
	for index, value in pairs(pointArray) do
		jucatoor = index
		rankul = (pointArray[jucatoor]/1000) + PH[jucatoor] + PRH[jucatoor] + 10*PD[jucatoor] + 10*PRD[jucatoor] + 20*PW[jucatoor] + 20*PRW[jucatoor]
		for index, value in pairs(rank) do
			if rankul > value then
				indexrang = index
			end
		end
		RANG[jucatoor] = rang[indexrang]
		indexrang = 0
	end
end
-----------------------------------------------------------------------------------------
function rangul()
-----------------------------------------------------------------------------------------
	if not RANG[curUser] then
		RANG[curUser] = "Oaspete"
	end
	rang1 = RANG[curUser]
	rankul = (pointArray[curUser]/1000) + PH[curUser] + PRH[curUser] + 10*PD[curUser] + 10*PRD[curUser] + 20*PW[curUser] + 20*PRW[curUser]
	for index, value in pairs(rank) do
		if rankul >= value then
			indexrang = index
		end
	end
	RANG[curUser] = rang[indexrang]
	rang2 = RANG[curUser]
	if not rang2 then
		blabla = 1
	else
		if rang1 ~= rang2 then
			if modulok == 1 then
				SendToPlayers(curUser..mesaje[124]..rang1..mesaje[125]..rang2)
			end
		 end
	end
	indexrang = 0
end
-----------------------------------------------------------------------------------------
function compensarepartone() --fct pusa sa citeasca premianti
-----------------------------------------------------------------------------------------
	if ac < 4 then
		if ac == 1 then
			rundacompensare = rundacompensare + 1
			nrcurentjw = nrcurentjw + 1
			jucatorwiner[nrcurentjw] = curUser
		elseif ac == 2 then
			nrcurentj = nrcurentj + 1
			jucatorcompensare[nrcurentj] = curUser
		elseif ac == 3 then
			nrcurentj = nrcurentj + 1
			jucatorcompensare[nrcurentj] = curUser
		end
		if rundacompensare == setare[5] then
			rundacompensare = 0
			boolcompensare = 1
			nrcurentjw = 0
			nrcurentj = 0
		end
	end
end
-----------------------------------------------------------------------------------------
function compensareparttwo()
-----------------------------------------------------------------------------------------
	if not boolcompensare then
		trist = 0
	else
		prezente = {}
		for index, value in pairs(pointArray) do
			nrprezente = 0
			usserr = index
			for index, value in pairs(jucatorcompensare) do
				if usserr == value then
					nrprezente = nrprezente + 1
				end
			end
			prezente[usserr] = nrprezente
			nrprezente = 0
			for index, value in pairs(jucatorwiner) do
				if usserr == value then
					nrprezente = nrprezente + 1
				end
			end
			if nrprezente ~= 0 then
				prezente[usserr] = 0
			end
		end
		alfa = prezente
		TopFirst(alfa)
		if punctedate ~= 0 then
			for index in pairs(primul) do
				user = primul[index]
				bonuscomp = 0
				mesaj1compensare = user.." ai fost cam melcusor si iti voi da un punctishor!"
				for ttta = 1, 3 do
					rn1 = math.random(1, 6)
					rn2 = math.random(1, 6)
					if rn1 == 1 and rn2 == 1 then nsc = 150
					elseif rn1 == 6 and rn2 == 6 then nsc = 100
					else nsc = 0
					end
					bonusbot = 10
					bonusbot3 = bonusbot * 3
					bonuscomp = bonuscomp + nsc + bonusbot
					if ttta == 1 then 
						mesajcompensare1 = "ZAR: "..rn1.."-"..rn2.."/"
						nsc1 = nsc
					elseif ttta == 2 then 
						mesajcompensare2 = rn1.."-"..rn2.."/"
						nsc2 = nsc
					elseif ttta == 3 then 
						mesajcompensare3 = rn1.."-"..rn2
						nsc3 = nsc
					end
					--SendToPlayers("ZAR - "..ttta.." :"..rn1.."-"..rn2..mesaje[61]..nsc)
				end
				mesajcompensare4 = "   NOROC: "..nsc1.."+"..nsc2.."+"..nsc3.."+"..bonusbot3.." = "..bonuscomp.."     ( "..bonusbot3.." daruiti de "..BotName.." )"
				mesajcompafisat = mesajcompensare1..mesajcompensare2..mesajcompensare3..mesajcompensare4
				--SendToPlayers(mesajcompafisat)
				if bonuscomp ~= 0 then
					pointArray[user] = pointArray[user] + bonuscomp
					pointHourArray[user] = pointHourArray[user] + bonuscomp
					pointDayArray[user] = pointDayArray[user] + bonuscomp
					pointWeekArray[user] = pointWeekArray[user] + bonuscomp
					mesaj2compensare = user ..mesaje[99]..bonuscomp..mesaje[100]..pointArray[user]
					SendToPlayers(liniutze2.."\r\n\t\t -:-"..mesaj1compensare.."\r\n\t\t -:-"..mesajcompafisat.."\r\n\t\t -:-"..mesaj2compensare)
					SendToPlayers(liniutze2)
					if teamArray[user] ~= 0 then
						for index, value in pairs(nameteam) do
							if teamArray[user] == index then
								pointteam[index] = pointteam[index] + bonuscomp
								SendToPlayers(mesaje[101]..nameteam[index]..mesaje[102]..pointteam[index].."  puncte.")
							end
						end
					end
				else
					SendToPlayers(user..mesaje[126])
				end
			end
		end
		jucatorcompensare = {}
		jucatorwiner = {}
		primul = {}
		Reset(alfa)
		SaveScores()
		boolcompensare = nil
		TimerTicks = 5
	end
end
-----------------------------------------------------------------------------------------
function resetstatisticihour()
-----------------------------------------------------------------------------------------
	for index, value in pairs(marimiorare) do
		vectorH = marimiorare[index]
		for index, value in pairs(pointArray) do
			vectorH[index] = 0
		end
	end
end
-----------------------------------------------------------------------------------------
function reparfile() --functie care repara fisierul de intrebari ( scoate spatiile de la inceput sau sfarsit, inlocuieste diacriticile si renumeroteaza intrebarile fara eventualele gauri)
-----------------------------------------------------------------------------------------
	rrasspunss = {}
	QtempWarray = {}
	local handle = io.open(strTrivreparatFile, "a")
	for index, value in pairs(guessArray) do
		final = ""
		QtempWarray = tokenize(guessArray[index], strGSep)
		strtempQuestion = QtempWarray[2]
		strtempWord = QtempWarray[3]
		strtempNr = QtempWarray[1]
		if not strtempWord then 
			SendToPlayers(strtempNr.."fara raspuns, --change this pls }{}{}{")
			strtempWord = "#####"
		end
		numar = 0
		numar = string.len(strtempWord)
		if numar > 50 then SendToPlayers(strtempNr.."---peste 50-- verifica u }{}{}{, pls") end
		for x=1, string.len(strtempWord) do
			caracter = string.sub(strtempWord, x, x)
			if x == 1 and caracter == " " then caracter = "" end
			if x == string.len(strtempWord) and caracter == " " then caracter = "" end
			if x == string.len(strtempWord) and caracter == "	" then caracter = "" end
			if caracter == "â" then caracter = "a"
			elseif caracter == "�." then caracter = "i"
			elseif caracter == "�." then caracter = "a"
			elseif caracter == "ţ" then caracter = "t"
			elseif caracter == "�." then caracter = "s"
			end
			final = final..caracter
		end
		strtempWord = final
		strtempNr = index
		handle:write(strtempQuestion..strGSep..strtempWord.."\r\n")
	end
	handle:close()
	SendToPlayers(" Am creat fisier reparat fara spatii la inceput si sfarsit si fara caracterele romanesti. \r\n I'm OK!")
end
-----------------------------------------------------------------------------------------
function showq()
-----------------------------------------------------------------------------------------
	nrQ = tonumber(nrQ)
	strNr = tonumber(strNr)
	if nrQ ~= strNr then
	  SendPMToUser(nrQ, curUser)
	  SendPMToUser(guessArray[nrQ], curUser)
	else
	  SendPMToUser("Asteapta sa treaca intrebarea", curUser)
	end
end
----------------------------------------------------------------------------------------
function updatefisiere() -- updateaza fisierele pentru a putea salva copiile de siguranta
----------------------------------------------------------------------------------------
      strTrivIniTimeFile = numecale.."initime.dat"
      strTrivHelpTxtFile = numecale.."helptxt.txt"
      strTrivScoreFile = numecale.."triviascores.dat"
      strTrivRunFile = numecale.."run.dat"
      strTrivRunHourFile = numecale.."runhour.dat"
      strTrivRunDayFile = numecale.."runday.dat"
      strTrivRunWeekFile = numecale.."runweek.dat"
      strTrivScoreHourFile = numecale.."triviahourscores.dat"
      strTrivScoreDayFile = numecale.."triviadayscores.dat"
      strTrivScoreWeekFile = numecale.."triviaweekscores.dat"
      strTrivLukyFile = numecale.."luky.dat"
      strTrivTeamNameFile = numecale.."teamsname.dat"
      strTrivTeamScoreFile = numecale.."teamscores.dat"
      strTrivStrikeFile = numecale.."strike.dat"
      strteamFile = numecale.."teamFile.dat"
      strTrivPremiiFile = numecale.."premiiFile.dat"
      strTrivStatFile = numecale.."statFile.dat"
      strTrivStatHFile = numecale.."statHFile.dat"
      strTrivDuelFile = numecale.."duelstatFile.dat"
      strTrivScorDuelFile = numecale.."duelscorFile.dat"
      strTrivBviFile = numecale.."bvi.dat"
      strDefTrivSpeedFile = numecale.."triviaspeed.dat"
      strDefTrivSpeed2File = numecale.."triviaspeed2.dat"
      strTrivScoreEternFile = numecale.."triviascoresE.dat"

end
--------------------------------------------------------------------------------
function myduel() -- arata statistica duelurilor tale
--------------------------------------------------------------------------------
	local handle = io.open(strTrivDuelFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			numarator = numarator + 1
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				if (arrTmp[1] == curUser) then
				  SendPMToUser(arrTmp[2].." scor "..arrTmp[3].." - "..arrTmp[4].."  ", curUser)
				 end
				if (arrTmp[2] == curUser) then
				  SendPMToUser(arrTmp[1].." scor "..arrTmp[4].." - "..arrTmp[3].."  ", curUser)
				 end
			 end
			line = handle:read()
		end
		handle:close()
	end
end
--------------------------------------------------------------------------------
function loadvitreactie() -- fuctie total nefolosita 
--------------------------------------------------------------------------------
	for index, value in pairs(recordman) do
		if not bestvitdereactie[value] then
		titular = value
		bestvitdereactie[titular] = tonumber(recordintrebare[index])
		for index, value in pairs(recordman) do
			if value == titular then
				if recordintrebare[index] < bestvitdereactie[titular] then
					bestvitdereactie[titular] = tonumber(recordintrebare[index])
				end
			end
		end
		end
	end
	for index, value in pairs(pointArray) do
		if not 	bestvitdereactie[index] then
			bestvitdereactie[index] = tonumber(15)
		end
	end
end
function scoretern()
end
--------------------------------------------------------------------------------
function updaterecord() -- top cu cate intrebari detinute
--------------------------------------------------------------------------------
	for index, value in pairs(pointArray) do
		detinator = index
		nrintdetinute[detinator] = 0
		for index, value in pairs(recordman) do
			if detinator == value then
				nrintdetinute[detinator] = nrintdetinute[detinator] + 1
			end
		end
	end
end
--------------------------------------------------------------------------------
function scriecategorii()
--------------------------------------------------------------------------------
	numarator = 0
	for index, value in pairs(guessArray) do
		numarator = numarator +1
		QWarray = tokenize(guessArray[numarator], strGSep)
		strQuestion = QWarray[2]
		strWord = QWarray[3]
		strNr = QWarray[1]
		if not strWord then strWord = "#####" end
		QWarray = tokenize(strQuestion, strGSep1)
		if not QWarray[2] then
			Category = "Altele:"
		else
			strQuestion = QWarray[2]
			Category = QWarray[1]
		end
		scrieintrebarea()
		strQuestion = ""
		strWord = ""
		strNr = ""
		Category = ""
	end
end
--------------------------------------------------------------------------------
function scrieintrebarea()
--------------------------------------------------------------------------------
	strTrivintrebariFile = numecale.."Intrebari/"..Category..".dat"
	local handle = io.open(strTrivintrebariFile, "a")
	handle:write(strQuestion..strGSep..strWord.."\r\n")
	handle:close()
end
-------------------------------------------------------------------------------
function stabilesteQmax() -- functia stabileste numarul de fisire cu intrebari indexQmax -nrmai mare cu 1 decat cel real
-------------------------------------------------------------------------------
	indexQmax = 1
	for indexQ = 1, 1000 do
		strTrivFilea = strDefTrivFile..indexQ..".dat"
		handle = io.open(strTrivFilea, "r")
		if (handle) then
			indexQmax = indexQmax + 1
		end
	end
	
	--SendToPlayers("numarul de fisiere cu intrebari este - "..indexQmax-1)
end
------------------------------------------------------------------------------
function stabilestelimsupcat() --functia stabileste numarul intrebarii pana la care tine o categorie 
-------------------------------------------------------------------------------
	indexator = 0
	for index, value in pairs(nrintrebaricat) do
	indexator = indexator + 1
	if indexator == 1 then
		limsupcat[indexator] = nrintrebaricat[indexator]
	else
		limsupcat[indexator] = limsupcat[indexator-1] + nrintrebaricat[indexator]
	end
	end
	indexator = 0
	--for index, value in pairs(limsupcat) do
	--SendToPlayers (index.." - "..value.." - "..nrintrebaricat[index])
	--end
end
--------------------------------------------------------------------------------
function numarQZ()
--------------------------------------------------------------------------------
	indexnrQ = 0
	for index, value in pairs(raspunszilnicArray) do
		indexnrQ = indexnrQ + 1
	end

end
--------------------------------------------------------------------------------
function stergeQZ()
--------------------------------------------------------------------------------
	numarQZ()
	nricts = indexnrQ - nrimem
	if indexnrQ > nrimem then
		for index, value in pairs(raspunszilnicArray) do
			if index < nricts then
				table.remove(raspunszilnicArray, index)
				--if index == nriapo then SendToPlayers("sterg primele "..nriapo) end
			end
		end
	end
end
--------------------------------------------------------------------------------
function fixnrQZ()
--------------------------------------------------------------------------------
	numarQZ()
	if indexnrQ > nrimem then
		table.remove(raspunszilnicArray, 1)
	end
	numarQZ()
	if indexnrQ > nrimem then
		fixnrQZ()
	end
end
--------------------------------------------------------------------------------
function alegeQ() -- alege intrebarile la inceputul orei
--------------------------------------------------------------------------------
	if boolsmartQ == 1 then
		stergeQZ()
		fixnrQZ()
		scriuQZ()
		ntemp = nrintrebaridef/nriapo
		--SendToPlayers("Nr temp "..ntemp)
		for index, value in pairs(nrintrebaricat) do
		nQpH[index] = value / ntemp
		temporarx = nQpH[index]
		if nQpH[index] < 1 then nQpH[index] = 1 end
		nQpH[index] = string.format("%.0f", nQpH[index])
		if (temporarx - nQpH[index]) > 1/2 then nQpH[index] = nQpH[index] +1 end
		--SendToPlayers (index.." - "..limsupcat[index].." - "..nrintrebaricat[index].." - "..nQpH[index])
		end		
		nrtot = 0
		for index, value in pairs(nQpH) do
			nrtot = nrtot + value		
		end
		--SendToPlayers("Nr tot "..nrtot)
		nrintext = 0 --nr intrebare extrasa
	else
		SendToPlayers(" - smartQ is disable.")
	end
	--extragNr()
	--aranjeazaQ()
end
--------------------------------------------------------------------------------
function extragNr()
--------------------------------------------------------------------------------
	numarator = 0
	for index, value in pairs(nQpH) do
		if not nQpH[index] then nQpH[index] = 0 end
		for indexant = 1,nQpH[index] do
			numarator = numarator + 1
			if index == 1 then
				limitainf = 1
			else
				limitainf = limsupcat[index - 1]
			end
			nrcatactuale = index
			alegnumarulQ()
			validareNQ()
			memorezRQZ()
			--SendToPlayers(numarator.." -- -- "..NrEx[numarator].." ----- "..index)
		end
	end
	scriuQZ()
	SendToPlayers(indqr.." - intrebari refuzate")
	indqr = 0
	--for index, value in pairs(NrEx) do
		--SendToPlayers(index.." - "..value)
	--end	
end
--------------------------------------------------------------------------------
function alegenewQ() --functie care alege noile intrebari
--------------------------------------------------------------------------------
	--stabileste cate intrebari din fiecare categorie trebuie
	for index, value in pairs(categorie_primaQ) do
		SendToPlayers(index.." - "..value)
		alfanx = categorie_ultimaQ[index] - categorie_primaQ[index] + 1
		table.insert(categorie_nrQ, alfanx)
	end
	nrintrebariT = 0
	for index, value in pairs(categorie_nrQ) do
		nrintrebariT = nrintrebariT + value
	end
	coeficientm = nrintrebariT / nriapo
	for index, value in pairs(categorie_nrQ) do
		coeficientmcat = value * coeficientm
		table.insert(categorie_nrQapH)
	end
	--stabileste o ordine aleatorie a categoriilor
	numarcategorii = 0	
	for index, value in pairs(categorie_nrQ) do
		numarcategorii = numarcategorii + 1
	end
	SendToPlayers(mesaje[127]..numarcategorii)
	randomized(1, numarcategorii)
	for index, value in pairs(fct) do
		table.insert(aleator_cat)
	end
	fct = {}
	for index, value in pairs(categorie_primaQ) do
		SendToPlayers(index.." - "..value)
	end
		
	--initiaza categoria care e la rand
	--verifica daca au iesit numarul de intrebari
	--stabileste o ordine aleatorie a intrebarilor in categorie
	--verifica daca intrebarea are voie sa iasa
end
-------------------------------------------------------------------------------
function alegnumarulQ()
--------------------------------------------------------------------------------
	NrEx[numarator] = math.random(limitainf, limsupcat[nrcatactuale])
end
--------------------------------------------------------------------------------
function validareNQ()
--------------------------------------------------------------------------------
	numarintrebarile = 0
	for index, value in pairs(raspunszilnicArray) do
		numarintrebarile = numarintrebarile + 1
	end
	if numarintrebarile == 1 then
		validezintrebarea = 1
	else
		nqexa = tonumber(NrEx[numarator])
		QWarray = tokenize(guessArray[nqexa], strGSep)
		raspunsactual = QWarray[2]
		nrvalidare = tonumber(0)
		for index, value in pairs(raspunszilnicArray) do
			if string.lower(raspunsactual) == string.lower(value) then
				nrvalidare = nrvalidare + 1
				nrvalidare = tonumber(nrvalidare)
			end
		end
		lungimeraspunsactual = string.len(raspunsactual)
		if lungimeraspunsactual == 0 then
				nrvalidare = nrvalidare + 1
				nrvalidare = tonumber(nrvalidare)
		end
		if nrvalidare ~= 0 then
			indqr = indqr + 1
			alegnumarulQ()
			validareNQ()
		end
	end
end
--------------------------------------------------------------------------------
function memorezRQZ()
--------------------------------------------------------------------------------
	table.insert(raspunszilnicArray,raspunsactual)
end
--------------------------------------------------------------------------------
function scriuQZ()
--------------------------------------------------------------------------------
	local handle = io.open(strTrivQDFile, "w")
	for index, value in pairs(raspunszilnicArray) do
		handle:write(value.."*\r\n")
	end
	handle:close()
end
--------------------------------------------------------------------------------
function loadQZ()
--------------------------------------------------------------------------------
	--SendToPlayers("citesc intrebarile iesite azi")
	local handle = io.open(strTrivQDFile, "r")
	if (handle) then
		line = handle:read()
		while line do
			if (line ~= "") and (1 == 1) then
				arrTmp = tokenize(line, strGSep)
				if (arrTmp[1] ~= nil) then
				table.insert(raspunszilnicArray, arrTmp[1])
				end
			end
			line = handle:read()
		end
		handle:close()
	end
	indqz = 0
	for index, value in pairs(raspunszilnicArray) do
		indqz = indqz + 1
	end
	--SendToPlayers(indqz.." - Intrebari iesite.")
end
--------------------------------------------------------------------------------
function aranjeazaQ()
--------------------------------------------------------------------------------
	numereal = {}
	numerealese = {}
	indexator1 = 0
	for i = 1, nriapo do
		table.insert(numereal, i)
	end
	nrintrebariramase = nriapo
	for i = 1, nriapo do
		extragnr = math.random(1, nrintrebariramase)
		extragnr = numereal[extragnr]
		table.insert(numerealese, extragnr)
		numereal = {}
		indexant3 = 0
		for i = 1,nriapo do
			for index, value in pairs(numerealese) do
				if i == value then indexant3 = 1 end
			end
			if indexant3 == 0 then
					table.insert(numereal, i)
			end
			indexant3 = 0
		end
		nrintrebariramase = nrintrebariramase -1			
	end
	--for index, value in pairs(numerealese) do
	--	SendToPlayers(index.." - "..value)
	--end
end
--------------------------------------------------------------------------------
function scrieduel()
	local handle = io.open(strTrivScorDuelFile, "w")
	for index, value in pairs(dueljucate) do
		if not duelcastigate[index] then duelcastigate[index] = 0 end
		if not duelcastigateazi[index] then duelcastigateazi[index] = 0 end
		if not duelpierdute[index] then duelpierdute[index] = 0 end
		if not duelegal[index] then duelegal[index] = 0 end
		handle:write(index..strGSep..value..strGSep..duelcastigate[index]..strGSep..duelpierdute[index]..strGSep..duelegal[index]..strGSep..duelcastigateazi[index].."\r\n")		end
	handle:close()
end
function randomized(nrmin, nrmax) -- fuctie care creaza un vector fct, cu numere asezate aleator intre nrmin si nrmax)
	fct = {}
	fcttemp = {}
	nrelemente = nrmax - nrmin + 1
	for i = 1, nrelemente do
		table.insert(fcttemp, i)
	end
	for i = 1, nrelemente do
		if i == 1 then nrelementeramase = nrelemente end
		alfax1 = math.random(1, nrelementeramase)
		table.insert(fct, fcttemp[alfax1])
		table.remove(fcttemp, alfax1)
		nrelementeramase = nrelementeramase - 1
	end
	for index, value in pairs(fct) do
		value = value + nrmin - 1
	end
end
--------------------------------------------------------------------------------
function sendvarmultiple()
--------------------------------------------------------------------------------
	if nrrv ~= 1 then
		strAfis = ""
		for index, value in pairs(varA) do
			if index == 1 then
				strAfis = value
			else
				strAfis = strAfis..", "..value
			end
		end
		SendGMToAll(BotName, "Raspunsuri posibile pentru intrebarea anterioara '"..strAfis.."'\r\n")
	end
end
--------------------------------------------------------------------------------
function loadsaveHD() -- incarca salvarile orare sau zilnice, calea siguranta 1 cand sunt orare si calea siguranta 2 cand se incarca salvarile zilnice
--------------------------------------------------------------------------------
	numecale = calesiguranta
	updatefisiere()
	LoadScores()
	loadmarimi()
	LoadScoresTeam()
	SaveScores()
	SendToPlayers("\r\n"..liniutze.."\r\n \t\t\t\tSalvarile au fost incarcate!\r\n"..liniutze)		
	numecale = caledefault
	updatefisiere()
end
--------------------------------------------------------------------------------
function LoadSetari()
--------------------------------------------------------------------------------
	setare = {}
	indexsetari = 0
	local handle = io.open(strTrivSetari, "r")
	if (handle) then
		local line = handle:read()
		while line do
			indexsetari = indexsetari + 1
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				setare[indexsetari] = tonumber(arrTmp[2])
				--arrTmp[1] = tonumber(arrTmp[2])
			end
		line = handle:read()
		end
		handle:close()	
	end
	SendToPlayers("- Settings are OK!...")
	--SendToPlayers(setare[1].."-1")
	--SendToPlayers(setare[2].."-2")


end
--------------------------------------------------------------------------------
function LoadMesaje()
--------------------------------------------------------------------------------
	mesaje = {}
	indexmesaje = 0
	local handle = io.open(strTrivMesaje, "r")
	if (handle) then
		local line = handle:read()
		while line do
			indexmesaje = indexmesaje + 1
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				mesaje[indexmesaje] = arrTmp[2]
				--arrTmp[1] = tonumber(arrTmp[2])
			end
		line = handle:read()
		end
		handle:close()	
	end
	SendToPlayers("- Messages are OK!...")
	SendToPlayers("       ***        I'm ready.       ***        Have Fun!    ***      ")
end

--------------------------------------------------------------------------------
function scriuQ()
--------------------------------------------------------------------------------
	mesaj = ""
	capat = "100"
	local handle = io.open(strTrivQuestion, "w")
	for y = 1, nrintrebaridef do
		mesaj = y..strGSep..categoria[y]..strGSep..autorul[y]..strGSep..dificultate[y]..strGSep..guessArray[y]..strGSep..capat
		handle:write(mesaj.."\r\n")
	end
	handle:close()
	SendToPlayers("Am scris fisier.")
end
--------------------------------------------------------------------------------
function scrielogset()
--------------------------------------------------------------------------------
	local handle = io.open(strTrivLogSet, "a")
	handle:write(curUser..strGSep..nrset.."-"..valset.."\r\n")
	handle:close()
end
--------------------------------------------------------------------------------
function sendsetariactuale()
--------------------------------------------------------------------------------
	SendPMToUser("-:-Setari actuale-:-", curUser)
	for index, value in pairs(setare) do
		SendPMToUser("Setare "..index.." - "..value, curUser)
	end	
end
--------------------------------------------------------------------------------
function scrielogowcmd()
--------------------------------------------------------------------------------
	local handle = io.open(strTrivLog, "a")
	handle:write(curUser..strGSep..cmd.."\r\n")
	handle:close()
end
function LoadQuestions()
-----------------------------------------------------------------------------------------
	SendToPlayers("- Loading...")
	GuessArray = {} -- pastram intrebarile pe categorii avand un numar guaessarray1 sunt intrebarile din primul fisier si au atorul author[1], dificultatea difficulty[1], si categoria category[1]
	category = {}
	author = {}
	difficulty = {}
	guessArray = {}
	nrintrebaridef = 0
	lngGuessmax = 0
	nrindex = 0
	indexQmax = 0
	for indexQ = 1, 1000 do
		strTrivFilea = strDefTrivFile..indexQ..".dat"
		handle = io.open(strTrivFilea, "r")
		if (handle) then
			indexQmax = indexQmax + 1
			GuessArray[indexQmax] = {}
		end
	end
	for indexQ = 1, indexQmax do -- indexQ este index fisier
	indexQ = tonumber(indexQ)
		strTrivFilea = strDefTrivFile..indexQ..".dat"
		nrindex = 0
		GuessArray[indexQ] = {}
		handle = io.open(strTrivFilea, "r")
		if (handle) then
			local line = handle:read()
			while line do
				--if line ~= "" then
				nrindex = nrindex + 1
					if nrindex == 1 then
					arrTmp = tokenize(line, strGSep)
						if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
							catg = arrTmp[1]
							auto = arrTmp[2]
							difi = arrTmp[3]
							table.insert(category, catg)
							table.insert(author, auto)
							table.insert(difficulty, difi)
							--SendToPlayers(catg)
						end
					else
						if ((line ~= nil) and (string.find(line, strGSep, 1, plain))) then
							table.insert(GuessArray[indexQ], line)
							table.insert(guessArray, line)
							lngGuessmax = lngGuessmax + 1
							nrintrebaridef = nrintrebaridef + 1
						end
					end
					line = handle:read()
				--end
			end
			handle:close()
			
		end
	end
	if (boolRestart) then
		SendToPlayers("Reloaded questions, game will be restarted! Current # of questions: "..nrintrebaridef)
		StartQuiz()
	end
	indexnrcat = 0
	SendToPlayers("- Number of categories - "..indexQmax.."...")
	chooseordercategory()
	local handle = io.open(strTrivstareqFile, "r")
	if (handle) then
		local line = handle:read()
		while line do
			local arrTmp = tokenize(line, strGSep)
			if ((arrTmp[1] ~= nil) and (arrTmp[2] ~= nil)) then
				arrTmp[1] = tonumber(arrTmp[1])
				arrTmp[2] = tonumber(arrTmp[2])
				stareQ[arrTmp[1]] = tonumber(arrTmp[2])
				
			end
			line = handle:read()
		end
		handle:close()
	end
------------------------------------stareQ------------------------------
	intrebariiesite = 0
	intrebaricustare = 0
	for index, value in pairs(stareQ) do
		intrebaricustare = intrebaricustare + 1
		if value == 1 then 
			intrebariiesite = intrebariiesite + 1
			--SendToPlayers(index)
		end
	end	
	SendToPlayers("- Total number of questions - "..intrebaricustare.." Displayed questions - "..intrebariiesite.."...")
	if nrQtotal > intrebaricustare then
		SendToPlayers("- New questions detected, database updated!")
		for indice1 = intrebaricustare + 1, nrQtotal do
			--SendToPlayers("Initializez - "..indice1)
			stareQ[indice1] = tonumber(0)
		end
	elseif 	nrQtotal == intrebaricustare then SendToPlayers("- Questions are OK!...")
	elseif nrQtotal < intrebaricustare then SendToPlayers("- Exista o problema cu intreabarile sau ati sters din ele.")
	end
end
--------------------------------------------------------------------------------
function chooseordercategory() -- la inceputul orei alege ordinea categoriilor
--------------------------------------------------------------------------------
	nrcategory = 0 -- initializeaza ( cate categorii sunt citite )
	nrrand = 1 -- al catelea rand e ( prima data lasa toate intrebarile sa trimita o intrebare apoi functie de numarul de intrebari din categorie refuza )
	tempcategory = {} 
	ordercategory = {}
	nrQtotal = 0  -- nr intrebari totale
	NrQcat = {} -- numarul intrebarilor din fiecare categorie
	dco = {} -- de cate ori pe ora vor fi alese intrebari din categoria x
	valdco = 0
	for index, value in pairs(category) do
		nrcategory = nrcategory + 1
		table.insert(tempcategory, index)
		nrqpercategorie = 0
		for index, value in pairs(GuessArray[index]) do
			nrqpercategorie = nrqpercategorie + 1
		end
		nrQtotal = nrQtotal + nrqpercategorie
		table.insert(NrQcat, nrqpercategorie)
	end
	nrqforone = tonumber(0.75*nrQtotal/nriapo)
	for index, value in pairs(NrQcat) do
		valdco = tonumber(value)/nrqforone
		table.insert(dco, valdco)
	end
	ind = 0
	nrcatfolosite = nrcategory
	for nq = 1, nriapo do
		ind = ind + 1
		if ind > nrcatfolosite then
			nrrand = nrrand + 1
			ind = 1
			tempcategory = {}
			nrcatfolosite = 0
			for index, value in pairs(category) do
				if dco[index] + 1 > nrrand then --dco[] de cate ori va intra o categorie in rand
					table.insert(tempcategory, index)
					nrcatfolosite = nrcatfolosite + 1
				end
			end
		end
		nrtempcategory = 0
		for index, value in pairs(tempcategory) do
			nrtempcategory = nrtempcategory + 1
		end
		tempooo = math.random(1, nrtempcategory)
		tempoo = tonumber(tempcategory[tempooo])
		table.insert(ordercategory, tempoo)
		table.remove(tempcategory, tempooo)
	end

end



---------------[ End functions ]------------------------------------------------



---------------[ Script entry point ]---------------
res, err = VH:AddRobot(BotName2, 10, "trivia-bot", " -:- ", " -:- ", "0")
res, err = VH:AddRobot(BotName1, 10, "trivia-bot", " -:- ", " -:- ", "0")
res, err = VH:AddRobot(BotName3, 10, "trivia-bot", " -:- ", " -:- ", "0")
loadQZ()
LoadQuestions()
LoadScores()
loadmarimi()
LoadIniTime()
LoadScoresTeam()
LoadSetari()
LoadMesaje()
initiereparametrii()
inirangul()
---------------[ End script entry point ]--------------- 



# Program under test
PROG        ?= test.pl
# Default goal to run
MAIN        ?= test

# All supported Prolog implementations (keep alphabetic order!)
PROLOGS     := b bin ciao eclipse gnu pop projog scryer swi trealla tau tu

.PHONY: $(PROLOGS) all
all: $(PROLOGS)

# Most prologs listed here don't currently work in Docker, add them to $(PROLOGS) when packaged and tested
b: $(PROG)
	bprolog -i $< -g '$(MAIN),halt'
bin: $(PROG)
	bp -p10 "consult('$<'),$(MAIN),halt"
ciao: $(PROG)
	ciao toplevel -u $< -e '$(MAIN),halt'
csh: $(PROG)
	cd '/opt/C#Prolog SF4.1' && env MONO_PATH=CSProlog/obj/Debug mono PLd/obj/Debug/PLd.exe "['$(realpath $<)'],$(MAIN),halt."
dgks:
	java -cp /usr/local/src/dgks-prolog/PrologO.zip prolog.dgks.prolog
doge: doge-js doge-py doge-java
doge-js: doge.pl
	node /usr/local/git/dogelog/player/canned/dogelog.mjs $<
doge-py: doge.pl
	python /usr/local/git/dogelog/playerpy/canned/dogelog.py $<
doge-java: doge.pl
	java -cp /usr/local/git/dogelog/playerj/canned/dogelog.zip:playerj/canned Index $<
doge.pl: $(PROG)
	$(file >$@,false :- \+true. ?- ['$<'],$(MAIN).)
eclipse: $(PROG)
	eclipse-clp -e "['$<'],$(MAIN)"
gnu: $(PROG)
	env TRAILSZ=999999 GLOBALSZ=999999 gprolog --consult-file $< --query-goal '$(MAIN),halt'
jlog: $(PROG)
	java -jar /opt/jlog/1.3.6/JLog.jar
pop: $(PROG)
	poplog prolog ":prolog_callstack_lim(10000000),prolog_memlim(10000000),prolog_area_lim(10000000),library(catch),assert(poplog),['$<'],$(MAIN)."
projog: $(PROG)
	java -cp '/usr/share/java/projog/*' org.projog.tools.ProjogConsole $< <(echo '?- $(MAIN).') <(echo '?- quit.')
scryer: $(PROG)
	scryer-prolog $< -g '$(MAIN),halt'
sicstus: $(PROG)
	/opt/SICStus/bin/sicstus -l $< --goal '$(MAIN),halt.'
swi: $(PROG)
	swipl -l $< -g '$(MAIN),halt'
tau:
	env NODE_PATH=$$(npm root -g) node /usr/share/tauprolog/tau.js $(PROG) '$(MAIN).'
trealla: $(PROG)
	tpl $< -g '$(MAIN),halt'
tu: $(PROG)
	java -jar /usr/share/java/tuprolog/2p-repl-1.0.4-redist.jar -T $< solve '$(MAIN)'
xsb: $(PROG)
	/usr/local/src/xsb-prolog/XSB/bin/xsb -e "use_module(lists,length/2),['$<'],$(MAIN),halt."
yap: $(PROG)
	yap -l $(PROG) -z $(MAIN)

# Program under test
PROG        ?= test.pl
# Default goal to run
MAIN        ?= test

# All supported Prolog implementations (keep alphabetic order!)
PROLOGS     := b bin ciao csh doge eclipse gnu pop projog scryer swi trealla tau tu xsb yap

.PHONY: $(PROLOGS) all
all: $(PROLOGS)

b: $(PROG)
	bprolog -i $< -g '$(MAIN),halt'
bin: $(PROG)
	bp -p10 "consult('$<'),$(MAIN),halt"
ciao: $(PROG)
	ciao toplevel -u $< -e '$(MAIN),halt'
csh: export MONO_PATH := CSProlog/obj/Debug
csh: $(PROG)
	cd /opt/cs-prolog && mono PLd/obj/Debug/PLd.exe "['$(realpath $<)'],$(MAIN),halt."
dgks:
	java -cp /usr/local/src/dgks-prolog/PrologO.zip prolog.dgks.prolog
doge: doge-node doge-pypy doge-java doge-bun doge-python
doge-%: doge.pl
	env 'DOGELOG_BACKEND=$*' dogelog $<
doge.pl: $(PROG)
	$(file >$@,false :- \+true. ?- ['$<'],$(MAIN).)
eclipse: $(PROG)
	eclipse-clp -e "['$<'],$(MAIN)"
gnu: export TRAILSZ  := 999999
gnu: export GLOBALSZ := 999999
gnu: $(PROG)
	gprolog --consult-file $< --query-goal '$(MAIN),halt'
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
tau: export NODE_PATH := $(shell npm root -g)
tau:
	node /usr/share/tauprolog/tau.js $(PROG) '$(MAIN).'
trealla: $(PROG)
	tpl $< -g '$(MAIN),halt'
tu: $(PROG)
	java -jar /usr/share/java/tuprolog/2p-repl-1.0.4-redist.jar -T $< solve '$(MAIN)'
xsb: $(PROG)
	xsb -e "['$<'],$(MAIN),halt."
yap: $(PROG)
	yap -l $(PROG) -z '$(MAIN)'

# Program under test
PROG        ?= test.pl
# Default goal to run
MAIN        ?= test

# All supported Prolog implementations (keep alphabetic order!)
PROLOGS     := b bin ciao csh doge eclipse gnu pop projog scryer swi trealla tau tu xsb yap

# FIXME: White spaces break badly for most rules
# FIXME: Filenames can be interpreted as arbitrary Prolog code

EMPTY :=
COMMA := ,
SPACE := $(EMPTY) $(EMPTY)
join-comma = $(subst $(SPACE),'$(COMMA)',$(strip $1))
join-include = $(patsubst %,include('%')$(COMMA),$(strip $1))

.PHONY: $(PROLOGS) all
all: $(PROLOGS)

b: $(PROG)
	bprolog $(addprefix -i ,$^) -g "($(MAIN)) -> true; write('%% Goal failed\n')" -g halt
bin: $(PROG)
	bp -p10 "consult('$<'),$(MAIN),halt"
ciao: $(PROG)
	echo "$(call join-include,$^) (catch(($(MAIN)),_,E=2) -> (E=0;true); E=1), halt(E)." | ciaosh
csh: export MONO_PATH := CSProlog/obj/Debug
csh: $(PROG)
	cd /opt/cs-prolog && mono PLd/obj/Debug/PLd.exe "['$(realpath $<)'],$(MAIN),halt."
dgks: export CLASSPATH := /usr/share/java/dgks-prolog/PrologO.zip
dgks:
	java prolog.dgks.prolog
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
	exec gprolog $(addprefix --consult-file ,$^) --query-goal '(catch(($(MAIN)), _, E=2) -> (E=0;true); E=1), halt(E)'
jlog: $(PROG)
	java -jar /opt/jlog/1.3.6/JLog.jar
pop: $(PROG)
	poplog prolog ":prolog_callstack_lim(10000000),prolog_memlim(10000000),prolog_area_lim(10000000),library(catch),assert(poplog),['$<'],$(MAIN)."
projog: $(PROG)
	java -cp '/usr/share/java/projog/*' org.projog.tools.ProjogConsole $< <(echo '?- $(MAIN).') <(echo '?- quit.')
scryer: $(PROG)
	exec scryer-prolog -g '(catch(($(MAIN)), X, (E=2,writeq(X),nl)) -> (E = 0; true); E = 1), halt(E)' $^
sicstus: $(PROG)
	/opt/SICStus/bin/sicstus -l $< --goal '$(MAIN),halt.'
swi: $(PROG)
	exec swipl -g '$(MAIN)' -g halt $^
tau: export NODE_PATH := $(shell npm root -g)
tau:
	node /usr/share/tauprolog/tau.js $(PROG) '$(MAIN).'
trealla: $(PROG)
	exec tpl -g '(catch(($(MAIN)), _, false) -> E = 0; E = 1), halt(E)' $^
tu: $(PROG)
	java -jar /usr/share/java/tuprolog/2p-repl-1.0.4-redist.jar $(addprefix -T,$^) solve 'true,(catch($(MAIN),_,E=2) -> (E=0;true); E=1),halt(E)'
xsb: $(PROG)
	exec xsb -e "(['$(call join-comma,$^)'], catch(($(MAIN)), _, E = 2) -> (E = 0; true); E = 1), halt(E)."
yap: $(PROG)
	exec yap -g "(['$(call join-comma,$^)'], catch(($(MAIN)), _, E = 2) -> (E = 0; true); E = 1), halt(E)"

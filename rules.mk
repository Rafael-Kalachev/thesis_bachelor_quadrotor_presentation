##
# MAKEFILE
##

##
# CONSTANTS
##
MATLAB:=octave-cli
MATLAB_ARGS:=

DIA:=dia
DIA_ARGS:=


##
# RULES
##

graphics/%.png: src/%.dia
	$(DIA) $(DIA_ARGS) --export=$@ $^

%.pdf: %.tex
	$(LATEXMK_PDF) -deps-out=$@.d $<


#%.res: %.m
#	$(MATLAB) $(MATLAB_ARGS)  $< > $@


%_tb.v: %.v
	echo "$< changed"

%.vvp: %.v
	iverilog -I src -o $@ $<

%.vcd: %.vvp
	vvp $< | grep -o '[a-zA-Z0-9_-]*.vcd' | xargs -I I mv I $@; gtkwave $@


%.res: %.m
	$(MATLAB_RUN_SCRIPT) $(MATLAB_RUN_SCRIPT_ARGS) `echo $(basename $^) | rev | cut -d '/' -f1 | rev`';exit' $(MATLAB_REDIRECT) $@.raw; \
	sed "s,\x1B\[[0-9;]*[a-zA-Z],,g;/Warning/d" $@.raw > $@

##
# PHONY
##

.PHONY: all auto clean show makedep

makedep: $(PROJECTS)
	echo "This functionality is not implemented yet" #TODO

force: clean all

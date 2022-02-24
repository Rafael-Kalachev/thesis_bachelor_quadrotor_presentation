##
# MAKEFILE
##


LATEX:=lualatex -file-line-error -interaction=nonstopmode
LATEXMK:=latexmk
LATEXMK_PDF:=$(LATEXMK) -pdf -pdflatex="$(LATEX)" -use-make -deps
LATEXMK_CLEAN:=$(LATEXMK) -C
#PDF_VIEWER:=xreader
PDF_VIEWER:=mupdf
MATLAB_SCRIPTS_LIST:= $(wildcard $(SOURCE_DIR)/*.m)
MATLAB_RUN_SCRIPT:=/usr/local/Polyspace/R2020b/bin/matlab
MATLAB_RUN_SCRIPT_ARGS:= -sd src -r
MATLAB_REDIRECT= -logfile
MATLAB_EXPORT_FIGURE:=/usr/local/Polyspace/R2020b/bin/matlab
MATLAB_EXPORT_FIGURE_ARGS:= -sd src -r


include projects.mk

.PHONY: all
all: $(PROJECTS)

.PHONY: clean
clean:
	$(LATEXMK_CLEAN); \
	rm -f $(PROJECTS) src/*.res || echo "No files have been removed by 'rm'"

.PHONY: show
show:	$(PROJECTS)
	$(PDF_VIEWER) $^ &

.PHONY: show_new
show_new: $(PROJECTS)
	$(PDF_VIEWER) $+ &

.PHONY: export_all

export_all: $(PROJECTS)
	echo $(PROJECTS) | xargs -I {} cp {} export/


include rules.mk

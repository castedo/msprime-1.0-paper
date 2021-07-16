DATA=data/arg.csv

FIGURES=figures/recombination.pdf\
	figures/mutation-perf.pdf\
	figures/arg.pdf\
	figures/gc-perf.pdf

paper.pdf: paper.tex paper.bib ${DATA} ${FIGURES}
	pdflatex paper.tex
	bibtex paper
	pdflatex paper.tex
	pdflatex paper.tex

figures/recombination.pdf:
	python3 evaluation/recombination.py

figures/%.pdf:
	python3 evaluation/plot.py $*

data/arg.csv:
	python3 evaluation/generate_arg_data.py

paper.ps: paper.dvi
	dvips paper

paper.dvi: paper.tex paper.bib
	latex paper.tex
	bibtex paper
	latex paper.tex
	latex paper.tex

clean:
	rm -f *.log *.dvi *.aux
	rm -f *.blg *.bbl
	rm -f *.eps *.[1-9]
	rm -f src/*.mpx *.mpx

mrproper: clean
	rm -f *.ps *.pdf

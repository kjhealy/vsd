## We need this Makefile for when we're working on the slides independently
## of the website's _targets.R pipeline.

## Convert single Rmd to HTML slide file
# Wildcard will match e.g. make slides/01-slides.Rmd
%.Rmd: .FORCE
	Rscript build/render_one_slide.R $@

## Convert single HTML slide file to PDF file
# Wildcard will match, e.g. make slides/01-slides.html
%.html: .FORCE
	Rscript build/decktape_one_file.R $@


slides: .FORCE
	Rscript -e "suppressMessages(library(knitr));suppressMessages(library(tidyverse)); kjhslides::kjh_render_all_slides()"

pdfs:
	Rscript -e "suppressMessages(library(knitr));suppressMessages(library(tidyverse)); kjhslides::kjh_decktape_all_slides()"

clean:
	find slides -type d -name '*_files' -prune -print -exec rm -rf {} +
	find slides -type d -name 'libs' -prune -print -exec rm -rf {} +
	find slides -type f -name '*.html' -prune -print -exec rm -f {} +
	find code -type f -name '*.R' -prune -print -exec rm -f {} +
	find pdf_slides -type f -name '*.pdf' -prune -print -exec rm -f {} +

.PHONY: clean

.FORCE:


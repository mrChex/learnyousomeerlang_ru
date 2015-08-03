SRC_DIR := src/
IMG_DIR := images/
PDF_DIR := pdf/
PDF_NAME := learnyousomeerlang_ru.pdf
EPUB_NAME := learnyousomeerlang_ru.epub
SRC_NAME := learnyousomeerlang_ru.tex
TEXCMD := TEXINPUTS=src: pdflatex -interaction=batchmode -output-directory $(PDF_DIR)
TEXCMDVERBOSE := TEXINPUTS=src: pdflatex -output-directory $(PDF_DIR)

all: $(PDF_NAME) $(IMG_DIR)*.png $(SRC_DIR)chapter*.tex clean

$(PDF_NAME): $(SRC_DIR)$(SRC_NAME) $(SRC_DIR)chapter*.tex
	$(TEXCMD) $(SRC_DIR)$(SRC_NAME) $(SRC_DIR)chapter*.tex

epub:
	latexml --dest=epub/$(EPUB_NAME).xml src/$(SRC_NAME)
	latexmlpost -dest=epub/$(EPUB_NAME).html epub/$(EPUB_NAME).xml
	ebook-convert epub/$(EPUB_NAME).html epub/$(EPUB_NAME) --language ru --no-default-epub-cover

ref: $(PDF_NAME)
	$(TEXCMD) $(SRC_DIR)$(SRC_NAME)

debug: $(SRC_DIR)$(SRC_NAME) $(SRC_DIR)chapter*.tex
	$(TEXCMDVERBOSE) $(SRC_DIR)$(SRC_NAME)

clean:
	rm -f $(PDF_DIR)*.aux $(PDF_DIR)*.log $(PDF_DIR)*.out epub/$(EPUB_NAME).*
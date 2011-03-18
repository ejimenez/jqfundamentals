V ?= 0

PREFIX = .
LANGUAGE = _es-ES
SRC_DIR = ${PREFIX}/book
INC_DIR = ${SRC_DIR}${LANGUAGE}/include
DIST_DIR = ${PREFIX}/publish

BOOK = ${DIST_DIR}${LANGUAGE}/index.html

TMPLPRE = '1h;1!H;$${;g;s/\(.*\)<%CONTENT%>\(.*\)/\1/g;p;}'
TMPLPOST = '1h;1!H;$${;g;s/\(.*\)<%CONTENT%>\(.*\)/\2/g;p;}'

book:
	@@mkdir -p ${DIST_DIR}${LANGUAGE}
	@@bk=`sed -n ${TMPLPRE} ${SRC_DIR}${LANGUAGE}/site.html`; \
	end=`sed -n ${TMPLPOST} ${SRC_DIR}${LANGUAGE}/site.html`; \
	for file in ${SRC_DIR}${LANGUAGE}/part*; do \
		body=`cat $$file/ch*`; \
		pre=`sed -n ${TMPLPRE} $$file/template.html`; \
		post=`sed -n ${TMPLPOST} $$file/template.html`; \
		bk="$$bk $$pre $$body $$post"; \
	done; \
	echo "$$bk $$end" > ${BOOK}
	@@cp -rf ${INC_DIR}/* ${DIST_DIR}${LANGUAGE}/
	@@echo "Creado ${BOOK} y copiados los contenidos de ${INC_DIR} dentro de ${DIST_DIR}${LANGUAGE}."

clean:
	@@echo "Removing Distribution directory:" ${DIST_DIR}${LANGUAGE}
	@@rm -rf ${DIST_DIR}${LANGUAGE}

.PHONY: book clean

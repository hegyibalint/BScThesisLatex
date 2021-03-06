PROJECTNAME=BScThesis

.PHONY: all clean osx

all:
	# Test if previos compilation was succesful, if not delete aux files
	if [ -a out/run2.pid ]; then rm -rf out; fi;
	if [ -a out/run1.pid ]; then touch out/run2.pid; fi;
	mkdir -p out pdf
	touch out/run1.pid

	mkdir -p out out/include out/chapters pdf
	cd tex; texfot latexmk -pdf -outdir=../out -jobname=$(PROJECTNAME) main; echo $?
	mv out/$(PROJECTNAME).pdf pdf/$(PROJECTNAME).pdf
	#gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=pdf/$(PROJECTNAME).pdf pdf/$(PROJECTNAME)-uncompressed.pdf

	# Remove pid file marking the succesful compilation
	rm  out/run*.pid

jenkins: clean all

osx: clean all
	open -a Skim pdf/$(PROJECTNAME)-uncompressed.pdf

clean:
	rm -rf ./out
	rm -rf ./pdf

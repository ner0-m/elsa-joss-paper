build: paper.md paper.bib
	cp paper.md paper/paper.md
	cp paper.bib paper/paper.bib
	docker run --rm --volume ${PWD}/paper:/data --user $(id -u):$(id -g) --env JOURNAL=joss openjournals/inara

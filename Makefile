THIS_FILE := $(lastword $(MAKEFILE_LIST))
THIS_FOLDER := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

run:
	docker-compose up -d

stop:
	docker-compose down

backup:
	docker run --rm -v dockerasciidoc_confluence-db:/volume -v $(THIS_FOLDER)data:/backup alpine tar -cjf /backup/confluence-db.tar.bz2 -C /volume ./
	docker run --rm -v dockerasciidoc_confluence:/volume -v $(THIS_FOLDER)data:/backup alpine tar -cjf /backup/confluence.tar.bz2 -C /volume ./
	docker run --rm -v dockerasciidoc_confluence-shared:/volume -v $(THIS_FOLDER)data:/backup alpine tar -cjf /backup/confluence-shared.tar.bz2 -C /volume ./
	
restore:
	docker run -it -v dockerasciidoc_confluence-db:/volume -v $(THIS_FOLDER)data:/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/confluence-db.tar.bz2"
	docker run -it -v dockerasciidoc_confluence:/volume -v $(THIS_FOLDER)data:/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/confluence.tar.bz2"
	docker run -it -v dockerasciidoc_confluence-shared:/volume -v $(THIS_FOLDER)data:/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/confluence-shared.tar.bz2"

clean: stop backup
	docker-compose down --volumes

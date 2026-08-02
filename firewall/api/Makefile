
include controllers.mk

CONTROLLERS_YML = $(CONTROLLERS_PHP:.php=.yml)

APIS_PY = $(CONTROLLERS_YML:.yml=.py)

all : yaml api

yaml : $(CONTROLLERS_YML)

%.yml : %.php
	python3 php2api.py -o $@ $<

api : $(APIS_PY)

%.py : %.yml
	python3 yml2py.py -o $@ $<

test :
	cp -f OPNsense/Core/Api/SystemController.py .
	python3 example.py | jq .

clean :
	rm -f $(CONTROLLERS_YML)
	rm -f $(APIS_PY)


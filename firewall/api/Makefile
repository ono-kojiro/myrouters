
-include controllers.mk

CONTROLLERS_YML = $(CONTROLLERS_PHP:Controller.php=.yml)

APIS_PY = $(CONTROLLERS_YML:.yml=.py)

all : yaml api

fetch :
	ssh firewall -l root \
		tar -C /usr/local/opnsense/mvc/app/controllers \
		-cJvf /tmp/OPNsense.tar.xz OPNsense
	scp root@firewall:/tmp/OPNsense.tar.xz .
	ssh firewall -l root rm -f /tmp/OPNsense.tar.xz

extract :
	tar -xJvf OPNsense.tar.xz

genmk :
	sh generate_controllers.sh > controllers.mk

yaml : $(CONTROLLERS_YML)

%.yml : %Controller.php
	python3 php2api.py -o $@ $<

api : $(APIS_PY)

%.py : %.yml
	python3 yml2py.py -o $@ $<

example :
	PYTHONPATH=OPNsense/Core/Api python3 example.py | jq .

clean :
	rm -f $(CONTROLLERS_YML)
	rm -f $(APIS_PY)

mclean :
	rm -rf OPNsense/



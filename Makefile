name = kea-dhcp4
version = 1.8.2

check_latest:
	# determine latest version of dnsdist
	docker pull ubuntu:focal
	docker run --rm -ti ubuntu:focal bash -c 'echo "deb https://dl.cloudsmith.io/public/isc/kea-1-8/deb/ubuntu focal main" >> /etc/apt/sources.list \
	&& apt-get -o "Acquire::AllowInsecureRepositories=true" -o "Acquire::https::Verify-Peer=false" update \
	&& apt-cache show --no-all-versions isc-kea-dhcp4-server'
	
build:
	docker pull ubuntu:focal
	docker build . --no-cache -t tmuncks/$(name):latest
	docker tag tmuncks/$(name):latest tmuncks/$(name):$(version)
	docker tag tmuncks/$(name):latest tmuncks/$(name):$(version)-$(shell date +%Y%m%d)

push:
	docker push tmuncks/$(name):latest
	docker push tmuncks/$(name):$(version)
	docker push tmuncks/$(name):$(version)-$(shell date +%Y%m%d)

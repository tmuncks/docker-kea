name = kea-dhcp4

# define major version
export version = 1.8

# repository is auto generated
export repo = "kea-$(subst .,-,$(version))"

check_latest:
	# determine latest version of kea dhcp server
	docker pull ubuntu:focal
	docker run --rm -ti ubuntu:focal bash -c 'echo "deb https://dl.cloudsmith.io/public/isc/$(repo)/deb/ubuntu focal main" >> /etc/apt/sources.list \
	&& apt-get -o "Acquire::AllowInsecureRepositories=true" -o "Acquire::https::Verify-Peer=false" update \
	&& apt-cache show --no-all-versions isc-kea-dhcp4-server'
	
build:
	docker pull ubuntu:focal
	cd docker && docker build . --no-cache --build-arg REPO=$(repo) -t tmuncks/$(name):latest
	docker tag tmuncks/$(name):latest tmuncks/$(name):$(version)

push:
	docker push tmuncks/$(name):latest
	docker push tmuncks/$(name):$(version)

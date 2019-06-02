check_latest:
	# determine latest version of kea
	docker run --rm -ti alpine:edge ash -c 'echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories ; apk update ; echo "-----"; apk search kea-dhcp4'

version = 1.5.0

build:
	docker build . --no-cache -t tmuncks/kea:latest
	docker tag tmuncks/kea:latest tmuncks/kea:$(version)
	docker tag tmuncks/kea:latest tmuncks/kea:$(version)-$(shell date +%Y%m%d)

push:
	docker push tmuncks/kea:latest
	docker push tmuncks/kea:$(version)
	docker push tmuncks/kea:$(version)-$(shell date +%Y%m%d)

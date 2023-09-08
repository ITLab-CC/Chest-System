buildpush:
	docker buildx build --platform linux/amd64,linux/arm64 -t registry.it-lab.cc/chest-system-server -f Dockerfile . --push
	docker buildx build --platform linux/amd64,linux/arm64 -t registry.it-lab.cc/chest-system-client -f my-app/Dockerfile ./my-app/ --push
	docker buildx build --platform linux/amd64,linux/arm64 -t registry.it-lab.cc/chest-system-proxy -f proxy/Dockerfile ./proxy --push

"Chest-System"

# Dev

```bash
export KUBECONFIG="$(pwd)/minikube-config.yaml"
minikube start


docker-compose -f docker-compose-proxy.yaml config > docker-compose-resolved.yaml
kompose convert -f docker-compose-resolved.yaml -o kube

kubectl apply -f kube


# Test
kubectl run test --rm --tty -i --restart='Never' --image alpine --namespace default --command -- /bin/sh
```

# Prod Build

The Images need to be in a public registry for the minikube to be able to pull them.

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-server -f Dockerfile . --push
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-client -f my-app/Dockerfile ./my-app/ --push
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-proxy -f proxy/Dockerfile ./proxy --push
```

```bash
export KUBECONFIG="$(pwd)/minikube-config.yaml"
minikube start


docker-compose -f docker-compose-proxy.yaml config > docker-compose-resolved.yaml
kompose convert -f docker-compose-resolved.yaml -o kube --namespace chest-system

kubectl apply -f kube
minikube service proxy
```

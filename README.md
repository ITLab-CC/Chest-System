# "Chest-System"

A chest system for organizing items typically refers to a method or physical arrangement of storage containers, such as chests, boxes, or drawers, used to categorize and store various items or belongings. This system is commonly employed in homes, businesses, and other environments to maintain order and facilitate easy access to stored items. Here are some key aspects of a chest system for organizing items:

- Containers: The main components of the system are the storage containers themselves, which can include chests, cabinets, bins, drawers, shelves, and more. These containers can vary in size, material, and design to suit specific organizational needs.

- Labeling: To enhance organization, it's essential to label the containers or compartments. You can use labels, tags, or even color-coding to quickly identify the contents of each storage space. This is especially helpful when dealing with a large number of items.

- Categorization: Items are grouped together based on similarities, usage frequency, or any other criteria that make sense for your specific needs. For instance, you might have separate containers for kitchen utensils, clothing, office supplies, or tools.

## Install Docker

Docker provides a install script. Just run:

```
curl -sSL https://get.docker.com | sh
```

By default, only users who have administrative privileges (root users) can run containers. You could also add your non-root user to the Docker group which will allow it to execute docker commands.

To add the current user to the Docker group run:

```
sudo usermod -aG docker ${USER}
```

## Website

- Port: '5050:80'
- Username: admin@admin.com
- Password: root

## Requirements

- VSC (Visual Studio Code)
- React/Next.js framework

## Start

- https://nextjs.org/docs/getting-started/installation
- created Main.py
- created docker-compose-dev

## QR-Code

## Dev

### Use a python virtual environment

```bash
python3 -m venv venv
source venv/bin/activate
```

### Install dependencies

```bash
pip install -r requirements.txt
```

### Start the dev database and phpmyadmin

```bash
docker-compose -f docker-compose-dev.yaml up -d
```

### Bring the dev database to the latest version

```bash
alembic upgrade head
```

### Start the dev server

```bash
uvicorn 'main:app' --host=127.0.0.1 --port=8000 --reload
```

Now you can access the server at http://127.0.0.1:8000

## Prod Build

The Images need to be in a public registry for the minikube to be able to pull them.

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-server -f Dockerfile . --push
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-client -f my-app/Dockerfile ./my-app/ --push
docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-proxy -f proxy/Dockerfile ./proxy --push
```

## Kubernetes

[IT-Lab Kubernetes Collection](https://github.com/ITLab-CC/kubernetes-collection/tree/main/chest-system)

```bash
export KUBECONFIG="$(pwd)/minikube-config.yaml"
minikube start

# Update the Kube-Files in kube/

kubectl apply -f ITLab-CC/kubernetes-collection/chest-system
minikube service proxy
```

buildpush:
	docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-server -f Dockerfile . --push
	docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-client -f my-app/Dockerfile ./my-app/ --push
	docker buildx build --platform linux/amd64,linux/arm64 -t skyface753/chest-system-proxy -f proxy/Dockerfile ./proxy --push



install-requirements:
	pip install -r requirements.txt

dev-docker:
	docker-compose -f docker-compose-dev.yaml up -d --build

run:
	uvicorn main:app --host 127.0.0.1 --port 8000 --reload

clear-db:
	docker-compose -f docker-compose-dev.yaml exec server alembic downgrade base

migrate-db:
	docker-compose -f docker-compose-dev.yaml exec server alembic upgrade head

reinit-db: clear-db migrate-db

integration-test:
	DATABASE_HOST=localhost \
	DATABASE_PORT=5432 \
	DATABASE_USERNAME=postgres \
	DATABASE_PASSWORD=mysecretpassword \
	DATABASE_NAME=postgres \
	POSTGRES_USER=postgres \
	POSTGRES_PASSWORD=mysecretpassword \
	POSTGRES_DB=postgres \
	PYTHONPATH=. pytest -x --junitxml=report_integration_tests.xml --verbose --cov=app --cov-config=.coveragerc --cov-report=xml:cov.xml tests/integration/



service-test:
	API_SERVER=localhost API_PORT=8000 PYTHONPATH=. pytest --pspec --verbose --color=yes --junitxml=report_service_tests.xml tests/service

test: service-test integration-test
run:
	docker run --name postgres -e POSTGRES_PASSWORD=admin -d -p 5432:5432 -v /db/data:/var/lib/postgresql/data postgres
stop:
	docker stop postgres
	docker rm postgres
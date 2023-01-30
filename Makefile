run:
	docker run --name postgres -e POSTGRES_USER=greenlight -e POSTGRES_DATABASE=greenlight -e POSTGRES_PASSWORD=admin -d -p 5432:5432 postgres
	sleep 1 && cat db/data/db_dump.sql | docker exec -i postgres psql -U greenlight -d greenlight
stop:
	docker exec postgres pg_dump -U greenlight -d greenlight > db/data/db_dump.sql
	docker stop postgres
	docker rm postgres
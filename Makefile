run:
	docker run --name postgres -e POSTGRES_PASSWORD=admin -d -p 5432:5432 -v db:/var/lib/postgresql/data postgres
	docker exec -it postgres psql -U postgres
	CREATE DATABASE greenlight;
	\c greenlight
	CREATE ROLE greenlight WITH LOGIN PASSWORD 'admin';
	docker exec -i postgres pg_restore -U postgres -v -d greenlight < db/data/db.dump
stop:
	docker exec postgres pg_dump -U postgres -d greenlight -Fc -f /var/lib/postgresql/data/db.dump
	docker cp postgres:/var/lib/postgresql/data/db.dump db/data/
	docker stop postgres
	docker rm postgres
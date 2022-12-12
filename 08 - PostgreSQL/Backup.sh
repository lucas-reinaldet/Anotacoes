
# a opção -f é para especificar um tipo de arquivo personalizado
# c significa tipo de arquivo personalizado
# d é formato de diretorio

docker exec -t container pg_dump -c database -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

docker exec -t container pg_dump -c database -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.dump

docker exec -t container pg_dump -c database -U postgres -p 5432 -t tabela > dump_`date +%d-%m-%Y"_"%H_%M_%S`.dump



docker exec -t PROJ_MI_DB_POSTGRESQL pg_dump -C -v -d db_lpr_itscampro_test -U postgres -p 8501 -t vehicle_ticket > dump.sql

docker exec -t PROJ_MI_DB_POSTGRESQL pg_dump -C -E 'utf-8' -F c -v -d db_lpr_itscampro_test -U postgres -p 8501 -t vehicle_ticket > dump.dump

docker exec -t PROJ_MI_DB_POSTGRESQL pg_dump -C -F c -v -d db_lpr_itscampro_test -U postgres > dump.dump


docker cp registros.dump PROJ_MI_DB_POSTGRESQL:/db.dump

docker exec -i PROJ_MI_DB_POSTGRESQL psql -U postgres < registros.dump

docker exec -i PROJ_MI_DB_POSTGRESQL pg_restore -U postgres -F c -C -d teste < registros1.dump



docker exec -t PROJ_MI_DB_POSTGRESQL pg_restore -v -d teste -U postgres < dump.sql

docker exec -i PROJ_MI_DB_POSTGRESQL pg_restore -F c --verbose --clean --no-acl --no-owner -U postgres -d db_lpr_itscampro_test < dump_03-08-2022_17_04_44.dump


docker exec -it 57010be3a686 bash

docker build -f postgressql.dockerfile -t postgres_tap:1.0 .

docker run --name postgres_tap -p 5432:5432 postgres_tap:1.0 --detach
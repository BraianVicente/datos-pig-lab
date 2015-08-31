-- cargamos la informacion de ratings 
ratings = load '../data/movies/ratings.dat' using PigStorage (';') 
            as (UseriD:int,
                MovieID:int,
                Rating:int,
                Timestamp:chararray);  

-- agrupamos los raitings por movie ID
grpd = group ratings by (MovieID);

--illustrate grpd;

-- Generamos el promedio de raitings para cada pelicula
avg = foreach grpd generate group as movie_id, AVG(ratings.Rating) as avg_rating;

--illustrate avg;

dump avg;
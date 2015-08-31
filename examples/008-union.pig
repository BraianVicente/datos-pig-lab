-- cargamos la informacion de ratings 
ratings = load '../data/movies/ratings.dat' using PigStorage (';') 
            as (UseriD:int,
                MovieID:int,
                Rating:int,
                Timestamp:chararray);  

-- obtenemos 10 ratings
ten_ratings = limit ratings 10;

-- obtenermos otros 5 rating
other_five = limit ratings 5;

-- hacemos la union, los formatos deben ser iguales
uni = union ten_ratings, other_five;

--describe uni;

dump uni;

-- si hacemos el distinct luego de hacer la union obtenemos 
-- el conjunto mas grande
--uni_distinct = distinct uni;
--dump uni_distinct;


-- cargamos la informacion de ratings 
ratings = load '../data/movies/ratings.dat' using PigStorage (';') 
            as (UseriD:int,
                MovieID:int,
                Rating:int,
                Timestamp:chararray);

-- cargamos movies.dat con separador ';' en movies 
-- y declarando los siguientes tipos
movies = load '../data/movies/movies.dat' using PigStorage (';') 
        as (m_MovieID:int,
            m_Title:chararray,
            m_Genre:chararray);                  

-- agrupamos los rating por pelicula
grpd = group ratings by (MovieID);

-- generamos los avg de cada pelicula incluyendo el total de raiting usango avg y count
avg_ratings = foreach grpd generate group as movie_id, AVG(ratings.Rating) as movie_avg, COUNT(ratings) as total;

-- now quedamos con aquellas que tienen mas de 10 calificaciones
avg_corrected = filter avg_ratings by total > 300;

-- hacemos el join de entre movies y raiting 
-- resultando en una relacion que va a tener la informacion de ambas
jnd = join movies by m_MovieID, avg_corrected by movie_id;

--describe jnd;
--illustrate jnd;

-- ordenamos los resultados de forma descendente
avg_sorted = order jnd by movie_avg desc;

--nos quedamos con el top 5
top_5 = limit avg_sorted 5;

-- ordenamos los resultados de forma descendente
avg_sorted_bottom = order jnd by movie_avg asc;

--nos quedamos con el bottom 5
bottom_5 = limit avg_sorted_bottom 5;

top_5_title = foreach top_5 generate m_Title as Title, movie_avg as rating_avg;
bottom_5_title = foreach bottom_5 generate m_Title as Title, movie_avg as rating_avg;

dump top_5_title;
--dump bottom_5_title;


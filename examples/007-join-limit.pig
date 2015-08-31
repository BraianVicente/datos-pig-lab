-- cargamos la informacion de ratings 
ratings = load '../data/movies/ratings.dat' using PigStorage (';') 
            as (r_UseriD:int,
                r_MovieID:int,
                r_Rating:int,
                r_Timestamp:chararray);

-- cargamos movies.dat con separador ';' en movies 
-- y declarando los siguientes tipos
movies = load '../data/movies/movies.dat' using PigStorage (';') 
        as (m_MovieID:int,
            m_Title:chararray,
            m_Genre:chararray);

-- hacemos el join de entre movies y raiting 
-- resultando en una relacion que va a tener la informacion de ambas
jnd = join movies by m_MovieID, ratings by r_MovieID;

--describe jnd;
--illustrate jnd;

movies_short = foreach jnd generate m_Title as Title, r_Rating as Rating;

-- agrupamos por titulo
grp = group movies_short by Title;

--illustrate movies_short;
--dump grp

movie_ratings = foreach grp generate group as movie_title, AVG(movies_short.Rating) as avg_rating;

--illustrate movie_ratings;
--dump movie_ratings;

movie_ratings_ordered = order movie_ratings by avg_rating desc;

--illustrate movie_ratings_ordered;

top_5 = limit movie_ratings_ordered 5;

dump top_5;




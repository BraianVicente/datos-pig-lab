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

grpd = group ratings by (MovieID);

avg_ratings = foreach grpd generate group, AVG(ratings.Rating) as Average, COUNT(ratings) as Total;

avg_corrected = filter avg_ratings by Total > 300;
        
jnd = join movies by m_MovieID, avg_corrected by group;

movie_ranking = foreach jnd generate m_Title, Average;

sorted = order movie_ranking by Average desc;

top5 = limit sorted 5;

sorted = order movie_ranking by Average asc;

last5 = limit sorted 5;

dump top5;

dump last5;
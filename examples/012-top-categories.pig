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

jnd = join movies by m_MovieID, ratings by MovieID;

grpd = group jnd by (m_Genre);

avg_ratings = foreach grpd generate group as Genre, AVG(jnd.ratings::Rating) as Average, COUNT(jnd) as Total;

describe avg_ratings;

avg_corrected = filter avg_ratings by Total > 20000;
        
sorted = order avg_corrected by Average desc;

top5 = limit sorted 5;

dump top5;

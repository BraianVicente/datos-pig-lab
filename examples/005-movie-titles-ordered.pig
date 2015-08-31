-- cargamos movies.dat con separador ';' en movies 
-- y declarando los siguientes tipos
movies = load '../data/movies/movies.dat' using PigStorage (';') 
        as (m_MovieID:int,
            m_Title:chararray,
            m_Genre:chararray);

-- generamos una nueva relacion a movie titles a partir de cada
-- uno de los registros de movies (usando un foreach)
-- generando una transformacion de datos
movies_titles = foreach movies generate m_Title as Title;

-- ordenamos movie_titles por m_Title
movies_ordered = order movies_titles by Title asc; 

dump movies_titles;
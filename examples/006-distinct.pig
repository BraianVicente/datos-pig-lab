-- cargamos movies.dat con separador ';' en movies 
-- y declarando los siguientes tipos
movies = load '../data/movies/movies.dat' using PigStorage (';') 
        as (m_MovieID:int,
            m_Title:chararray,
            m_Genre:chararray);

-- generamos una relacion con generos        
genres = foreach movies generate m_Genre as Genre;

-- eliminamos los duplicados
genres_distinct = distinct genres;

dump genres_distinct;
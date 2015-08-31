-- cargamos movies.dat con separador ';' en movies 
-- y declarando los siguientes tipos
movies = load '../data/movies/movies.dat' using PigStorage (';') 
        as (m_MovieID:int,
            m_Title:chararray,
            m_Genre:chararray);

-- devuelve el schema de la relacion movies
--describe movies;

-- generamos una nueva relacion a movie titles a partir de cada
-- uno de los registros de movies (usando un foreach)
-- generando una transformacion de datos
movies_titles = foreach movies generate m_Title as Title;

-- muestra una ejecucion paso a paso de una serie de statements 
-- de nuestro script
illustrate movies_titles;

-- muestra el contenido de movies_titles en pantalla
dump movies_titles;
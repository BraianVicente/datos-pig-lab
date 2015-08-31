-- cargamos users.dat utilizando ; como separador y declarando los siguientes tipos.
users = load '../data/movies/users.csv' using PigStorage (';') 
            as (UseriD:int,
                Gender:chararray,
                Age:int,
                Occupation:int,
                ZipCode:chararray);  

-- devuelve el schema de la relacion users
describe users

-- selecciona una muestra aleatoria basandose cierto sample size (%10).
users_sample = sample users 0.1;

-- devuelve el schema de la relacion users_sample (es igual al de users)
describe users_sample;

--baja el contenido de users sample a disco
store users_sample into '../data/output/users-sample';

--muestra el contenido de users sample en pantalla
dump users_sample;

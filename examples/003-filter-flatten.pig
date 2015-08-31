-- cargamos el contenido de users.dat como una relacion de chart-array
users = load '../data/movies/users.dat' as (line:chararray);

-- 'plancha' (un-nest) un bag o una tupla
-- generando una nueva relacion
person = foreach users generate FLATTEN(STRSPLIT(line,'::')) 
        as (UseriD:chararray,
            Gender:chararray,
            Age:chararray,
            Occupation:chararray,
            ZipCode:chararray);

-- filtramos aquellos users que son hombres
person_M = filter person by Gender == 'M';

dump person_M;
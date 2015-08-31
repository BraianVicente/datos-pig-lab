-- cargamos users.dat utilizando ; como separador y declarando los siguientes tipos.
users = load '../data/movies/users.csv' using PigStorage (';') 
            as (UseriD:int,
                Gender:chararray,
                Age:int,
                Occupation:int,
                ZipCode:chararray);  

person_F = filter users by Gender == 'F';

person_F_18_34 = filter person_F by Age > 17 and Age < 35;

illustrate person_F_18_34;

dump person_F_18_34;
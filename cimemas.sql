
--  Se connecter a mySQL en ligne de commande : 
mysql -u root -p 
-- apres saisi du mot de passe s'il y en a un , la console MariaDB affiche :   MariaDB [(none)]>



-- Afficher la liste des databases : 
SHOW databases;

-- Creation de la base de donnée cinemas : 
CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Se connecter a la database cinemas :
USE cinemas;
-- la console MariaDB affiche alors : MariaDB [cinemas]>


--creation Admistrateur  'Admin1' ayant tous les droits:

CREATE USER 'Admin1'@'localhost' IDENTIFIED BY 'LM461&4568mk20'; 
GRANT ALL PRIVILEGES ON * . * TO 'Admin1'@'localhost';


--creation utilisateur 'user1' pouvant uniquement voir les données:

CREATE USER 'user1'@'localhost' IDENTIFIED BY 'M456&1259mf86'; 
GRANT SELECT ON * . * TO 'user1'@'localhost';


-- Creation des tables :

CREATE TABLE IF NOT EXISTS complex_group
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) NOT NULL    
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS movie_theatre
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(50) NOT NULL ,
    adress VARCHAR(250) NOT NULL ,
    city VARCHAR(50) NOT NULL ,
    postal_code VARCHAR(5) NOT NULL ,
    email VARCHAR(100) NOT NULL ,
    id_complex_group INT NOT NULL ,
    FOREIGN KEY (id_complex_group) REFERENCES complex_group(id)
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS movie_room
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    room_number INT(10) NOT NULL ,    
    seats_quantity INT(10) NOT NULL ,  
    id_movie_theatre INT NOT NULL ,
    FOREIGN KEY (id_movie_theatre) REFERENCES movie_theatre(id)
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS movie
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL ,      
    movie_year YEAR NOT NULL ,
    director VARCHAR(50) NOT NULL ,  
    duration TIME NOT NULL    
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS session
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_time DATETIME NOT NULL ,  
    id_movie INT NOT NULL ,
    id_movie_room INT NOT NULL ,
    FOREIGN KEY (id_movie) REFERENCES movie(id) ,
    FOREIGN KEY (id_movie_room) REFERENCES movie_room(id)
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS customer
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    customer_name VARCHAR(50) NOT NULL ,
    customer_first_name VARCHAR(50) NOT NULL ,    
    customer_email VARCHAR(100) NOT NULL ,
    customer_login VARCHAR(100) NOT NULL ,
    customer_password VARCHAR(100) NOT NULL     
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS price_list
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL ,       
    price DECIMAL(5,2) NOT NULL 
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS booking
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    booking_date DATETIME NOT NULL , 
    payment_type VARCHAR(50) NOT NULL ,    
    id_customer INT NOT NULL ,
    id_session INT NOT NULL ,
    id_price_list INT NOT NULL ,    
    FOREIGN KEY (id_customer) REFERENCES customer(id) ,
    FOREIGN KEY (id_session) REFERENCES session(id) ,
    FOREIGN KEY (id_price_list) REFERENCES price_list(id) 
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS info_user
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,      
    info_role VARCHAR(50) NOT NULL , 
    info_login VARCHAR(100) NOT NULL ,
    info_password VARCHAR(100) NOT NULL ,
    info_name VARCHAR(50) NOT NULL , 
    info_email VARCHAR(100) NOT NULL ,
    id_complex_group INT NOT NULL ,
    FOREIGN KEY (id_complex_group) REFERENCES complex_group(id)      
) ENGINE=InnoDB ;





-- insertion de données pour simulation et tests.


INSERT INTO complex_group (group_name)  VALUES  ( 'Complexes Star Cinemas') ;


INSERT INTO movie_theatre (name , adress , city , postal_code , email , id_complex_group)
VALUES
( 'Star Cinema Paris 6' , '4 rue Emile Zola' , 'PARIS' , '75006' , 'paris6@csc.fr' , '1') ,
( 'Star Cinema Toulouse', '20 Boulevard Matabio' , 'TOULOUSE' , '31000' , 'toulouse@csc.fr' , '1') ,
( 'Star Cinema Angers', '11 rue Honoré de Balzac' , 'ANGERS' , '49000' , 'angers@csc.fr' , '1') ,
( 'Star Cinema Nice', '12 Rue Scaliero' , 'NICE' , '06000' , 'nice@csc.fr' , '1') ,
( 'Star Cinema Vernon' , '35 rue Jean Paul Belmondo' , 'VERNON' , '27200' , 'vernon@csc.fr' , '1') ;


INSERT INTO movie_room (room_number , seats_quantity , id_movie_theatre)
VALUES
( '1' , '210' , '1') ,
( '2' , '170' , '1') ,
( '3' , '150' , '1') ,
( '4' , '120' , '1') ,
( '5' , '90' , '1') ,
( '6' , '80' , '1') ,

( '1' , '200' , '2') ,
( '2' , '160' , '2') ,
( '3' , '140' , '2') ,
( '4' , '100' , '2') ,
( '5' , '80' , '2') ,

( '1' , '190' , '3') ,
( '2' , '170' , '3') ,
( '3' , '130' , '3') ,
( '4' , '100' , '3') ,
( '5' , '70' , '3') ,

( '1' , '200' , '4') ,
( '2' , '180' , '4') ,
( '3' , '150' , '4') ,
( '4' , '120' , '4') ,
( '5' , '100' , '4') ,
( '6' , '70' , '4') ,

( '1' , '160' , '5') ,
( '2' , '110' , '5') ,
( '3' , '90' , '5') ,
( '4' , '60' , '5') ;


INSERT INTO movie (title , movie_year , director , duration)
VALUES
( 'Avatar 2' , '2022' , 'James Cameron' , '02:46:00') ,
( 'Super-héros malgré lui' , '2022' , 'Philippe Lacheau' , '01:22:00') ,
( 'Moonfall' , '2022' , 'Roland Emmerich' , '02:01:00') ,
( 'Mort sur le Nil' , '2022' , 'Kenneth Branagh' , '02:07:00') ,
( 'Uncharted' , '2022' , 'Ruben Fleischer' , '01:55:00') ;


INSERT INTO session (date_time , id_movie_room , id_movie)
VALUES
( '2022-02-16 14:15:00' , '1' , '1') ,
( '2022-02-16 14:15:00' , '2' , '1') ,
( '2022-02-16 14:30:00' , '4' , '2') ,
( '2022-02-16 14:45:00' , '3' , '5') ,
( '2022-02-16 14:00:00' , '5' , '4') ,
( '2022-02-16 15:00:00' , '6' , '3') ,

( '2022-02-16 14:25:00' , '7' , '1') ,
( '2022-02-16 20:05:00' , '7' , '1') ,
( '2022-02-16 14:00:00' , '8' , '3') ,
( '2022-02-16 14:15:00' , '9' , '5') ,

( '2022-02-16 14:00:00' , '12' , '1') ,
( '2022-02-16 14:15:00' , '13' , '3') ,
( '2022-02-16 14:45:00' , '14' , '2') ,
( '2022-02-16 15:10:00' , '15' , '5') ,

( '2022-02-16 14:00:00' , '17' , '1') ,
( '2022-02-16 20:00:00' , '17' , '1') ,
( '2022-02-16 14:45:00' , '18' , '4') ,
( '2022-02-16 15:10:00' , '20' , '3') ,

( '2022-02-16 14:00:00' , '23' , '1') ,
( '2022-02-16 14:15:00' , '24' , '3') ,
( '2022-02-16 14:35:00' , '25' , '2') ,
( '2022-02-16 15:00:00' , '26' , '5') ;


INSERT INTO price_list (category , price)
VALUES
( 'Plein tarif' , '9.20') ,
( 'Etudiant' , '7.60') ,
( 'Moins de 14 ans' , '5.90') ;


INSERT INTO customer (customer_name , customer_first_name , customer_email , customer_login , customer_password)
VALUES
('Trethewey', 'Erina', 'etrethewey0@free.fr', 'Zoolab', '$2y$10$nxOGsEPWD2m7NqQHLE6fBuIUA/MltoNZAJjhvYyCyx4zWoeW46qNi') ,
('Matre', 'Karine', 'kmatre@aol.com', 'Voltsillam', '$2y$10$UWpcGl/LzKbhcmmAUa/i1uqmKX0l8J5GZCqCeCqoJzJq.UvtBir.2') ,
('Petrichat', 'Patrick', 'cpat.petrichat2@free.fr', 'Tin25', '$2y$10$j7dxml.QPbf2O96Hbcm5X.fNzYn3rxbYkD1/a5y9oJxfOpwZXT4p2') ,
('Ambros', 'Rachèle', 'ahobben3@orange.fr', 'QuoLux', '$2y$10$5z.hmuW4uiMvrAE1n5HeFOxgAbNUG8ef6yKuortNVq2uGXDInaMiK') ,
('Divis', 'Pénélope', 'pdivis5@yahoo.fr', 'Y-Solowarm', '$2y$10$rzCwX3XYvNzDq/8DZQrKheqwBgBD4piCTGKORN1pKdkWld8umfJvC') ,
('Zambala', 'Honoré', 'h.Zambala6@orange.fr', 'Viva32', '$2y$10$EzCqF2hM15AdAY965n5vJOKQM13RRI7x7bf13hd..nf3G74KIwGRK') ,
('Wright', 'Peter', 'p-wright@google.com', 'SnakeBite', '$2y$10$UsDY3gh3y.9sNlB/h1EgNu69OnYsPdNJVZGc1dGlZaRTmsm5k3XiS') ,
('Karoui', 'Hakim', 'hakim562@yahoo.com', 'Duobam', '$2y$10$E9feS1pG0xUQQzjtH8elbuXM3m1.42pOKSiCOXiFiE.gLbROCWflS') ,
('Dubois', 'Kilian', 'k.dubois@free.fr', 'Cardguard', '$2y$10$nHgqNPaexf0G1BYQmKh7XekoGP114qeSsddfW.a9zLIF2HZzu6s.W') ,
('Nicolau' , 'José' , 'JNicolau@laposte.fr' , 'gap658', '$2y$10$SnqXfR5r8ptVpeSk7XQQme1Mu9ptXEXhxWuaDI9WwU6iJXoBQreWG') ;
   

INSERT INTO booking (booking_date , payment_type , id_customer , id_session , id_price_list)
VALUES
('2022-02-12 20:06:35' , 'CB' , '1' , '1' , '1') ,
('2022-02-12 20:06:35' , 'CB' , '1' , '1' , '1') ,
('2022-02-12 20:06:35' , 'CB' , '1' , '1' , '3') ,
('2022-02-12 20:06:35' , 'CB' , '1' , '1' , '3') ,
('2022-02-12 21:03:21' , 'CB' , '2' , '4' , '1') ,
('2022-02-12 21:03:21' , 'CB' , '2' , '4' , '2') ,
('2022-02-12 21:50:18' , 'non reglé' , '3' , '9' , '1') ,
('2022-02-13 10:04:52' , 'CB' , '4' , '10' , '1') ,
('2022-02-13 11:23:07' , 'CB' , '5' , '11' , '1') ,
('2022-02-13 11:23:07' , 'CB' , '5' , '11' , '1') ,
('2022-02-13 11:23:07' , 'CB' , '5' , '11' , '2') ,
('2022-02-13 18:07:24' , 'CB' , '6' , '12' , '2') ,
('2022-02-13 20:55:37' , 'non reglé' , '7' , '15' , '1') ,
('2022-02-14 08:43:02' , 'CB' , '8' , '18' , '2') ,
('2022-02-14 12:25:22' , 'CB' , '9' , '20' , '1') ,
('2022-02-14 12:25:22' , 'CB' , '9' , '20' , '1') ,
('2022-02-14 18:53:01' , 'CB' , '10' , '21' , '1') ;


INSERT INTO info_user (info_role , info_login , info_password , info_name , info_email , id_complex_group)
VALUES
('Admin' , 'Admin1' , '$2y$10$t.BD/pjr1aXMTqxfDtXkMO/4a75YRvPVXjYGcCaZFbC8QO19XD6qC' , 'Durand Patrick' , 'admin1@csc.fr' , '1' ) ,
('Admin' , 'Admin2' , '$2y$10$IbMfkJBQP7vkx5.RcSRRtuwO5KpdTXydIs.bji3GGwaxHHVA2G7F.' , 'Vale Isabelle' , 'admin2@csc.fr' , '1' ) ,
('user' , 'user1_paris6' , '$2y$10$YSivXz7HSzSApSdleelzS.K9ybzytCi/DSdiTJ9UeGKjdxr1.tjFi' , 'Menot Stella' , 'user1_paris6@csc.fr' , '1' ) ,
('user' , 'user1_toulouse' , '$2y$10$wjCGdfCRQvPnnp6veH9.Vez19jv145zgVS261jUpZe2zxcY0/GzhO' , 'Blanc Eric' , 'user1_toulouse@csc.fr' , '1' ) ,
('user' , 'user1_angers' , '$2y$10$rq5VJZq4BbK9PdUMqtr4D.MHT/mtaDILLnJO/CW1gf2ZHV9iMVdN2' , 'Sicora Michelle' , 'user1_angers@csc.fr' , '1' ) ,
('user' , 'user1_nice' , '$2y$10$HPk3lvNcC3cdLGf.mQUB9.vikLNCCtpErve7ndkidVQZK9rGUyzLy' , 'Mercier Stephanie' , 'user1_nice@csc.fr' , '1' ) ,
('user' , 'user1_vernon' , '$2y$10$K2Znhp1KezLMH3vwvRemI.KKYcXaN7KbQepuBOxLpnxhgcjEn.7vK' , 'Petit Luc' , 'user1_vernon@csc.fr' , '1' ) ;




-- Tests de CRUD :

-- CREATION  ( nouveau tarif)
INSERT INTO price_list (category , price)
VALUES
( 'VIP' , '11.50') ;
-- verification du nouveau tarif :
SELECT 
category ,
price
FROM price_list 
WHERE price_list.category = 'VIP' ;



-- UPDATE :
-- on verifie la cible  ( price )
SELECT 
category ,
price
FROM price_list 
WHERE price_list.category = 'VIP' ;

-- on modifie la ligne concernée

UPDATE price_list 
SET  price = '12.20'
WHERE price_list.price = '11.50'
AND price_list.category = 'VIP';

-- verification des données la ligne modifiée :
SELECT 
category ,
price
FROM price_list 
WHERE price_list.category = 'VIP' ;



-- DELETE :
-- pour la suppression de la ligne de category 'VIP' 
-- on verifie avant l'exactitude de la cible de la requete avec SELECT
SELECT *
FROM price_list 
WHERE price_list.category = 'VIP' ;

-- on utilise aussi l'id de valeur '4' pour securiser la requete de suppression
DELETE FROM `price_list`
WHERE price_list.category = 'VIP' 
and price_list.id = '4' ;

-- verification de cette suppression :
SELECT *
FROM price_list ;




-- Exécution de requêtes pour 
-- les différents tarifs :

SELECT * FROM price_list ;


-- les différents cimemas du groupe :

SELECT
 movie_theatre.name as 'Nom cinéma' ,
movie_theatre.city as 'Ville'
FROM  movie_theatre ;


-- liste de tous les films qui sont programmés ( pas forcement dans tous les cinemas ) un jour precis  ( 16-12-2022 )  

SELECT
 movie.title as 'Films'  ,
 date(session.date_time) as 'Date' 
 FROM  movie
 JOIN session ON movie.id = session.id_movie
    WHERE
   date(date_time) = '2022-02-16' 
   GROUP BY movie.title ;


-- liste des films projetés dans un cinema ( Angers) un jour precis ( 16-12-2022 )  

SELECT
 movie.title as 'Films'  ,
 date(session.date_time) as 'Date' ,
 movie_theatre.name as 'Nom cinéma'
 FROM  movie_theatre 
 JOIN movie_room ON movie_theatre.id = movie_room.id_movie_theatre 
 JOIN session ON movie_room.id = session.id_movie_room   
 JOIN movie ON movie.id = session.id_movie   
 WHERE  
movie_theatre.city = 'ANGERS'
AND date(session.date_time) = '2022-02-16'   
GROUP BY movie.title ;


-- liste des films projetés dans un cinema ( Paris ) le 16-12-2022  avec heure des seances
-- Le blockbuster'Avatar 2' est projeté dans 2 salles differentes du meme cinema et a la meme heure , ce qui est conforme aux souhaits du client

SELECT
movie.title as 'Films'  ,
movie_room.room_number as 'Salle N°' ,
time(session.date_time) as 'Début de seance' ,
movie.duration as 'Durée' ,
 movie_theatre.name as 'Nom cinéma'
 FROM  movie_theatre 
 JOIN movie_room ON movie_theatre.id = movie_room.id_movie_theatre 
 JOIN session ON movie_room.id = session.id_movie_room   
 JOIN movie ON movie.id = session.id_movie   
 WHERE  
movie_theatre.city = 'Paris'
AND date(session.date_time) = '2022-02-16'
ORDER BY session.date_time ;


--liste des places reservés par des clients dans un cinema ( Paris ) le 16-12-2022  

SELECT
customer.customer_name   as 'Nom du client' ,
price_list.category  as 'Ticket' ,
price_list.price  as 'Tarif' ,
booking.payment_type as 'Payé' , 
movie.title as 'Film'  ,
movie_room.room_number as 'Salle N°' ,
time(session.date_time) as 'Debut de seance' ,
movie.duration as 'Durée' ,
 movie_theatre.name as 'Nom Cinéma'
 FROM  movie_theatre 
 JOIN movie_room ON movie_theatre.id = movie_room.id_movie_theatre 
 JOIN session ON movie_room.id = session.id_movie_room   
 JOIN movie ON movie.id = session.id_movie 
 JOIN booking ON session.id = booking.id_session 
 JOIN customer ON customer.id = booking.id_customer
 JOIN price_list ON price_list.id = booking.id_price_list
 WHERE  
movie_theatre.city = 'Paris'
AND date(session.date_time) = '2022-02-16'
ORDER BY session.date_time ;


--  Administrateurs info du group

SELECT
info_user.info_name as 'Noms Administrateurs' ,
info_user.info_role as 'Role' ,
info_user.info_login as 'Login' ,
info_user.info_email as 'Mail' ,
complex_group.group_name as 'Nom Groupe'
FROM  complex_group
 JOIN info_user ON complex_group.id = info_user.id_complex_group 
WHERE
info_user.info_role = 'Admin' ;


--  Utilisateurs info des cinemas

SELECT
info_user.info_name as 'Noms Utilisateurs' ,
info_user.info_role as 'Role' ,
info_user.info_login as 'Login' ,
info_user.info_email as 'Mail' 
FROM  complex_group
 JOIN info_user ON complex_group.id = info_user.id_complex_group 
WHERE
info_user.info_role = 'user' ;


-- Calcul  du nombre de places restantes dans une salle 

SELECT
movie.title as 'Film' ,
session.date_time as 'Seance' ,
movie_theatre.name as 'Nom Cinema' ,
movie_room.room_number as 'Salle N°',
movie_room.seats_quantity as 'Places',
movie_room.seats_quantity - count(booking.id_session) as 'Places restantes'
 FROM  movie_theatre 
 JOIN movie_room ON movie_theatre.id = movie_room.id_movie_theatre 
 JOIN session ON movie_room.id = session.id_movie_room   
 JOIN movie ON movie.id = session.id_movie 
 JOIN booking ON session.id = booking.id_session  
 WHERE  
movie_theatre.city = 'Paris'
AND movie_room.room_number ='1' 
AND date(session.date_time) = '2022-02-16'
ORDER BY session.date_time ;




-- Exportation de la base de donnée (en etant dans le repertoire contenant mysqldump.exe , en ligne de commande :)

mysqldump -u root -p cinemas > cimemas.sql


-- Importation de la base de donnée , si la base n'existe pas ,  la créer avant,  avec : 
 CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- et lancer l'import de la base de donnée  :

mysql -u root -p cinemas < cimemas.sql




-- !!! SUPPRIMER  la base de données ( apres export ) !!!
 DROP DATABASE cinemas ;


-- supprimer les acces et privileges de 'Admin1'
REVOKE ALL PRIVILEGES ON *.* FROM 'Admin1'@'localhost';
-- et supprimer 'Admin1'
DROP USER 'Admin1'@'localhost';

-- supprimer les acces et privileges de 'user1'
REVOKE ALL PRIVILEGES ON *.* FROM 'user1'@'localhost';
-- et supprimer 'user1'
DROP USER 'user1'@'localhost';











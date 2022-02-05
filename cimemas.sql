
--  Se connecter a mySQL en ligne de commande : 
mysql -u root -p 
-- apres saisi du mot de passe s'il y en a un , la console MariaDB affiche :   MariaDB [(none)]>


-- Afficher la liste des databases : 
SHOW databases;

-- Creation de la base de donnée cinemas : 
CREATE DATABASE IF NOT EXISTS cinemas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Se positionner sur la database cinemas :
USE cinemas;
-- la console MariaDB affiche alors : MariaDB [cinemas]>


--creation Admistrateur  Admin1 ayant tous les droits:

CREATE USER 'Admin1'@'localhost' IDENTIFIED BY 'LM461&4568mk20'; 
GRANT ALL PRIVILEGES ON * . * TO 'Admin1'@'localhost';


--creation utilisateur user1 pouvant uniquement voir les données:

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



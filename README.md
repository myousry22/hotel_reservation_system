# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.2, Rails v 6.1, DB Postgres 

* System dependencies
  - you should have docker installed on your machine 

* Configuration 
  1- run docker-compose build
  2- run docker-compose up   

* Database creation
  1- docker-compose exec web rails db:create
  2- docker-compose exec web rails db:migrate
  3- docker-compose exec web rails db:seed  

* Docker Containers 
  - web app 
  - db 

 
* core functionality 
  - Users 
    - register guest user 
    - log in as a guest 
    - system has three user roles [admin, operator, owner, guest] 
  - Rooms
    - create room type
    - list room types
    - update room type
    - create a reservation
    - list all reservation
    - cancel a reservation

- the system has also authorization control by pundit gem
- the system handles multiple users trying to reserve the same room type for
  overlapping dates.
- the system has a logging and monitoring integration with appsignal APM

* the used gems 
  - devise, jwt, appsignal, interactors, pundit, jsonapi-serializer

* How to use the apis 
 - in the Postman collection that i attached below 
   1- use register API to add new guest account 
   2- use login API to generate the auth token 
   3- copy the token and add it in any request you need to use in the headers with    
      Authorization -> Bearer {{token}}  in postman 

<img width="1015" alt="Screen Shot 2023-11-06 at 1 08 11 PM" src="https://github.com/myousry22/hotel_reservation_system/assets/26511051/b7e279f0-caae-480d-ba71-c0dfa86406d4">


AppSignal
<img width="1424" alt="Screen Shot 2023-11-06 at 11 27 00 AM" src="https://github.com/myousry22/hotel_reservation_system/assets/26511051/0a8fc306-1e4c-4d50-990b-9c56c8162f7b">
<img width="1424" alt="Screen Shot 2023-11-06 at 11 28 08 AM" src="https://github.com/myousry22/hotel_reservation_system/assets/26511051/c8b0b5ce-9ce8-436e-8c39-30fe06e87dfb">

DB diagram 
<img width="903" alt="Screen Shot 2023-11-06 at 4 53 57 PM" src="https://github.com/myousry22/hotel_reservation_system/assets/26511051/38e56bf3-32e7-4a29-b17b-90172ec9f554">


Postman Collection
https://drive.google.com/file/d/1eK0H1iWqEsz1mECn91l3_VJ2Q4vJO7rW/view?usp=sharing

just download the file and click import in the top left in Postman to import the collection
<img width="946" alt="Screen Shot 2023-11-06 at 1 26 46 PM" src="https://github.com/myousry22/hotel_reservation_system/assets/26511051/d4c96feb-6a69-43ce-94af-0721212c95f4">


* ...

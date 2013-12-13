##Quick start
The scripts are in version 0 or something, so follow these steps exactly.

1. Install virtualbox and vagrant on your machine.

2. Clone this repo.

3. Every developer needs the fakta-backend. From repo. folder
        
        ./apps/fakta-backend.sh 

4. Still in repo. folder 

        vagrant up

5. Test with curl ( Ommiting the pipe if you don't have a python with mjson.tool. Highly recommended though )

        curl -v 
        -H "Accept:application/json" 
        -H "Content-type:application/json" 
        -X GET http://localhost:3000/ | python -mjson.tool 

6. Clone whatever apps you need to work on, by issuing 

        ./apps/<app-name>.sh
        vagrant provision

7. Start coding in emacs :)

##Details

##Suggestions
Install pgadmin and redis-commander on your own machine. These are tools for managing postgres and redis.
postgres can be accesed at: localhost:?
redis can be accesed at: localhost:?

When developing you might want to start two vagrant ssh sessions. 
Start Foreman in one of them, and use the other for commands such as bundle install and rake tasks.
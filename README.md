##Quick start
The scripts are in version 0 or something, so follow these steps exactly.

1. Install virtualbox and vagrant on your machine.

2. Clone this repo.

3. From repo. folder
        
        ./apps/fakta-backend.sh 

4. Still in repo. folder 

        vagrant up

5. Test with curl ( Ommiting the pipe if you don't have a python with mjson.tool. Highly recommended though )

        curl -v 
        -H "Accept:application/json" 
        -H "Content-type:application/json" 
        -X GET http://localhost:3000/ | python -mjson.tool 

6. Clone whatever apps you want to work on, by issuing 

        ./apps/<app-name>.sh
        vagrant provision

7. Start coding in emacs :)

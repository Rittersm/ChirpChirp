# ChirpChirp Read Me and Documentation

Heroku site: https://calm-beach-80027.herokuapp.com


POST https://calm-beach-80027.herokuapp.com/signup

  - POST Creates a new user
  - Required Params:
    - Username
    - Email
    - Password
    - Avatar

  - Returns:

    On Success (200): {
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "api_token": "1a6e3091fe06851c0ee6bfdd1c2fa440727ad5d0",
      "avatar": "http://example.com",
      "created_at": "2016-07-25T18:33:20.237Z"
    }

    On Validation Failure (422): [
      "Password can't be blank",
      "Username has already been taken",
      "Email has already been taken",
      "Avatar can't be blank"
    ]

POST https://calm-beach-80027.herokuapp.com/login    

  - POST Logs User In
  - Required Params:
    - Email
    - Password

  - Returns:

    On Success (200): {
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "api_token": "1a6e3091fe06851c0ee6bfdd1c2fa440727ad5d0",
      "avatar": "http://example.com",
      "created_at": "2016-07-25T18:33:20.237Z"
    }

    On Validation Failure (422):{
      "error": "Incorrect Password"
      "error": "Unrecognized Email"
    }   

GET https://calm-beach-80027.herokuapp.com/timeline

    - GET Curren_User Timeline
    - Required Params:
      - api_token

    - Returns:

    On Success (200):{
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "avatar": "http://example.com",
      "followees_count": 0,
      "followers_count": 0,
      "created_at": "2016-07-25T18:33:20.237Z",
      "followees": [],
      "followers": [],
      "timeline_posts": []
    }  

    On Validation Failure (422):{
      "errors": [
        {
          "error": "You must be logged in"
        }
      ]
    }

GET https://calm-beach-80027.herokuapp.com/users

    - GET List of All users
    - Required Params:
      - api_token

    - Returns:

    On Success (200):[
      {
        "id": 25,
        "username": "declan",
        "email": "letitia@example.org",
        "avatar": "https://robohash.org/4745.png?bgset=bg1",
        "followees_count": 3,
        "followers_count": 5,
        "is_following": true,
        "created_at": "2015-12-11T04:25:16.000Z"
      }, ...
    ]

    On Failure (403):{
      "errors": [
        {
          "error": "You must be logged in"
        }
      ]
    }     

GET https://calm-beach-80027.herokuapp.com/chirps

    - GET User Personal Page
    - Required Params:
      - api_token
      - id ('me' if current_user, id if otherwise)

    - Returns:

    On Success (200):{
      "id": 55,
      "username": "reva_-hammes",
      "email": "dale@example.net",
      "avatar": "https://robohash.org/2945.png?bgset=bg1",
      "followees_count": 8,
      "followers_count": 10,
      "created_at": "2015-12-01T07:01:06.000Z",
      "followees": [
        {
          "id": 42,
          "username": "jayne",
          "email": "joan@example.net",
          "avatar": "https://robohash.org/2642.png?bgset=bg1",
          "followees_count": 5,
          "followers_count": 9,
          "is_following": false,
          "created_at": "2015-12-21T11:00:15.000Z"
        } ... ],
        "followers": [
        {
          "id": 41,
          "username": "chance",
          "email": "dennis@example.net",
          "avatar": "https://robohash.org/614.png?bgset=bg1",
          "followees_count": 6,
          "followers_count": 2,
          "is_following": false,
          "created_at": "2015-12-19T14:29:11.000Z"
        } ... ],
        "posts": [
          {
            "body": "Gastropub tacos knausgaard synth tousled.",
            "created_at": "2016-07-12T18:39:17.000Z",
            "user": {
              "id": 55,
              "username": "reva_-hammes",
              "email": "dale@example.net",
              "avatar": "https://robohash.org/2945.png?bgset=bg1",
              "followees_count": 8,
              "followers_count": 10,
              "created_at": "2015-12-01T07:01:06.000Z"
            }
          } ... ]

    On Failure (No ID exists):
      status: 404 Not found

POST https://calm-beach-80027.herokuapp.com/follow

  - POST Creates a Following Relationship Between users
  - Required Params:
    - api_token
    - id

  - Returns:

    On Success (200):{
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "avatar": "http://example.com",
      "followees_count": 1,
      "followers_count": 0,
      "created_at": "2016-07-25T18:33:20.237Z",
      "followees": [
        {
          "id": 55,
          "username": "reva_-hammes",
          "email": "dale@example.net",
          "avatar": "https://robohash.org/2945.png?bgset=bg1",
          "followees_count": 8,
          "followers_count": 11,
          "is_following": true,
          "created_at": "2015-12-01T07:01:06.000Z"
        } ... ]
    }

    On Failure (409):{
      "error": "You Already Follow This Person"
    }

POST https://calm-beach-80027.herokuapp.com/unfollow

  - POST Removes a Following Relationship Between Users
  - Required Params:
    - api_token
    - id

  - Returns:

    On Success (200):{
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "avatar": "http://example.com",
      "followees_count": 0,
      "followers_count": 0,
      "created_at": "2016-07-25T18:33:20.237Z",
      "followees": []
    }

    On Failure (409):{
      "error": "You Were Not Following This Person"
    }

GET https://calm-beach-80027.herokuapp.com/following

  - GET List of Users Selected User is Following
  - Required Params:
    - api_token
    - id ('me' if current user, id if otherwise)

  - Returns:

    On Success (200):{
      "id": 103,
      "username": "bravo",
      "email": "alpha@example.com",
      "avatar": "http://example.com",
      "followees_count": 3,
      "followers_count": 0,
      "created_at": "2016-07-25T18:33:20.237Z",
      "followees": [
        {
          "id": 25,
          "username": "declan",
          "email": "letitia@example.org",
          "avatar": "https://robohash.org/4745.png?bgset=bg1",
          "followees_count": 3,
          "followers_count": 5,
          "is_following": true,
          "created_at": "2015-12-11T04:25:16.000Z"
        }, ... ]
      }    

    On Failure (No ID exists):
      404 Not Found

GET https://calm-beach-80027.herokuapp.com/followers

  - GET List of Users following Selected Users
  - Required Params:
    - api_token
    - id ('me' if current_user, id if otherwise)

  - Returns:

    On Success (200):{
      "id": 25,
      "username": "declan",
      "email": "letitia@example.org",
      "avatar": "https://robohash.org/4745.png?bgset=bg1",
      "followees_count": 3,
      "followers_count": 5,
      "created_at": "2015-12-11T04:25:16.000Z",
      "followers": [
        {
          "id": 103,
          "username": "bravo",
          "email": "alpha@example.com",
          "avatar": "http://example.com",
          "followees_count": 3,
          "followers_count": 0,
          "is_following": false,
          "created_at": "2016-07-25T18:33:20.237Z"
        }, ... ]
    }  

    On Failure (No ID exists):
      404 Not found

POST https://calm-beach-80027.herokuapp.com/post

  - POST Creates post by User
  - Required Params:
    - api_token
    - body

  - Returns:

    On Success (200):{
      "body": "This is a sample post from when you create a post.",
      "created_at": "2016-07-25T19:48:08.221Z",
      "user": {
        "id": 103,
        "username": "bravo",
        "email": "alpha@example.com",
        "avatar": "http://example.com",
        "followees_count": 3,
        "followers_count": 0,
        "created_at": "2016-07-25T18:33:20.237Z"
      }
    }

    On Validation Failure (422):{
      "body": [
        "is too long (maximum is 170 characters)"
      ]
    }

GET https://calm-beach-80027.herokuapp.com/search
  - GET Searches Database for Matching Users and Posts
  - Required Params:
    - api_token
    - search ('lan' in this instance)

  - Returns:

    On Success (200):[
      {
        "id": 25,
        "username": "declan",
        "email": "letitia@example.org",
        "avatar": "https://robohash.org/4745.png?bgset=bg1",
        "followees_count": 3,
        "followers_count": 5,
        "is_following": true,
        "created_at": "2015-12-11T04:25:16.000Z"
      }, ...
      {
        "body": "Flannel next level fingerstache hoodie venmo austin ennui.",
        "created_at": "2016-07-22T23:17:01.000Z",
        "user": {
          "id": 28,
          "username": "vincenzo",
          "email": "melia@example.org",
          "avatar": "https://robohash.org/4907.png?bgset=bg1",
          "followees_count": 2,
          "followers_count": 4,
          "created_at": "2015-11-27T21:24:11.000Z"
        }
      }, ... ]

      On Failure (404):{
        "error": "Nothing Matched Your Search"
      }



### Endpoints

#### Private API responding to the following requests:

  1. GET  /v1/public/locations/:code
  1. GET  target_groups/:country_code
  1. POST /v1/public/locations/:code


### Authentication 

i'm using devise-token_authenticatable gem to make simple token based authentication for users 
you can create user by sign up with email and password then you will revecie token that you using for auth , you can logout and use the email and password to get fersh token 

             `sign_in_user POST   /user/sign_in                                                                  
             sign_out_user DELETE /user/sign_out                                                                 u
             sign_up_user POST   /user/sign_up`                                                                  
  when the user sign in he recieve token that should use in headers to authenticate his request 
`'HTTP_AUTHORIZATION' =>
          "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\""`

*devise_token_auth gem provide more secure way for authentication as it invalidate the token every request but it's easy to be integrated with rails but i preferd to user simpler and less secure authentication for the sake of simplicity and easier testing with curl or postman*

#### Public API responding to the following requests

  1. GET  /v1/public/locations/:country_code
  1. GET  /v1/public/target_groups/:country_code

# Tests 
 **models**

    open_lib_array_spec.rb
    time_a_spec.rb
    times_html_spec.rb
    target_spec.rb

**requests**

    evaluate_target_spec.rb
    locations_spec.rb
    target_groups_spec.rb


i'm using rspec for testing with Faker to create dummy data and FactoryBot 
use ./bin/rspec to run specs 
some of tests are integration tests requests i used webmock in it to mock the response of time website 

### Implementaion notes and details 
//todo 

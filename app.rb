require 'sinatra'
require 'slim'
require "bcrypt"

# hashed_password = BCrypt::Password.create "my password"
# storable_string = hashed_password.to_s

# restored_hash = BCrypt::Password.new storable_string

# puts hashed_password

storable_string = "$2a$12$tLL00wickBpuQQDnz381uOZz4zwrLYBm2ojHk1kneBIRvLM1auvNO"

restored_hash = BCrypt::Password.new storable_string

if restored_hash == "daniel29329399"
    puts "funkar"
end

login_credentials = File.readlines("crypted_users.csv")
p login_credentials[0]

get ('/') do
    return slim(:homepage)
end

get ('/lektioner') do
    return slim(:lessons, locals:{key:x})
end

get ('/om_oss') do
    return slim(:om_oss)
end

get ('/quiz') do
    return slim(:quiz)
end

get ('/login') do
    return slim(:login)
end

get('/lektioner/:user') do |user|
    important_data = [user,"blomquist","gurka"]
    
    x = {
        fname:important_data[0],
        lname:important_data[1],
        favfood:important_data[2]
    }
    
    return slim(:lessons, locals:{key:x})
end

get('/testdatapost') do

    return slim(:testdatapost)
end
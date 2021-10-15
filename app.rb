require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'
require_relative 'db_saker.rb'

enable :sessions

db = SQLite3::Database.new('db/db.db')
db.results_as_hash = true


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
    index()
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

get('/register') do
    return slim(:register)
end

post('/login') do
    login()    
end

post('/logout') do
    session.destroy
    redirect('/')
end

post('/new_thread') do
    new_thread()
end

post('/reply/:threadId') do
    reply()
end

post('/delete_thread') do
    delete_thread()
end

post('/create') do
    create()
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

post('/getpost') do
    ownmake()
end
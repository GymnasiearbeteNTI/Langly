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

#Alla get-metoder

get ('/') do
    slim(:homepage)
end

get ('/teori') do
    slim(:teori)
end

get ('/om_oss') do
    return slim(:om_oss)
end

get ('/quiz') do
    return slim(:quiz)
end

get ('/register') do
    return slim(:register)
end

#Om man inte skriver något efter

get ('/lektioner') do
    if session[:loggedin_user] == nil
        redirect('/login')
    else
        redirect("/lektioner/#{session[:loggedin_user]}")
    end
end

 #Om man skriver något efter

 get('/lektioner/:user') do |user|

    x = {
        fname:user,
        lname:"ditt efternamn",
        favfood:"nånting",
    }
    if session[:loggedin_user] == user
        slim(:lessons, locals:{key:x})
    else
        redirect('/')
    end
end

get('/login') do
    return slim(:login)
end

#Alla post-metoder

post('/create') do
    registerfunc()
end

post('/login') do
    loginfunc()
end

post('/logout') do
    session.destroy
    redirect('/')
end
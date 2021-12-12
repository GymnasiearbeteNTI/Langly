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
    session[:quiz_result] = nil
    session[:reg_error] = nil
    slim(:homepage)
end

get ('/teori') do
    slim(:teori)
end

get ('/about') do
    return slim(:about)
end

get ('/quiz') do
    return slim(:quiz)
end

get ('/register') do
    return slim(:register)
end

get('/login') do
    return slim(:login)
end

#Om man inte skriver något efter

get ('/courses') do
    if session[:loggedin_user] == nil
        redirect('/login')
    else
        redirect("/courses/#{session[:loggedin_user]}")
    end
end

#Om man skriver något efter

get('/courses/:user') do |user|

    x = {
        fname:user
    }
    if session[:loggedin_user] == user
        slim(:courses, locals:{key:x})
    else
        redirect('/')
    end
end

#Lektionernas get-metoder

get('/choose_spanish') do
   return slim(:choose_spanish)
end

get('/spanish/visual') do
    visual_learning = {
        title:"Visual Learning",
        intro:"Here you will learn with a little help from images and other visual media #{session[:loggedin_user]}!"
    }
    return slim(:spanish, locals:{key:visual_learning})
end

get('/spanish/text') do
    text_learning = {
        title:"Text Learning",
        intro: "Read spanish text and learn along the way#{session[:loggedin_user]}!"
    }
    return slim(:spanish, locals:{key:text_learning})
end

get('/spanish/audio') do
    audio_learning = {
        title:"Audio Learning",
        intro: "Listen to spanish and learn along the way#{session[:loggedin_user]}!"
    }
    return slim(:spanish, locals:{key:audio_learning})
end

get('/choose_swedish') do
    return slim(:choose_swedish)
end

get('/swedish') do
    return slim(:swedish)
end

get('/swedish/visual') do
    visual_learning = {
        title:"Visual Learning"
    }
    return slim(:swedish, locals:{key:visual_learning})
end

get('/swedish/text') do
    text_learning = {
        title:"Text Learning"
    }
    return slim(:swedish, locals:{key:text_learning})
end

get('/swedish/audio') do
    audio_learning = {
        title:"Audio Learning"
    }
    return slim(:swedish, locals:{key:audio_learning})
end

#Post-metoder

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

post('/results') do

    if params["right"] == "on" && params["right2"] == "on" && params["wrong"] != "on"
        session[:quiz_result] = true
    else
        session[:quiz_result] = false
    end

    if params["right"] == "on" && params["right2"] == "on" && params["wrong"] != "on"
        session[:quiz_result] = true
    else
        session[:quiz_result] = false
    end
    redirect('/quiz')
end
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
    session[:log_error] = nil
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

get ('/courses') do
    if session[:loggedin_user] == nil
        redirect('/login')
    else
        redirect("/courses/#{session[:loggedin_user]}")
    end
end

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
        intro: "Read spanish text and learn along the way #{session[:loggedin_user]}!"
    }
    return slim(:spanish, locals:{key:text_learning})
end

get('/spanish/audio') do
    audio_learning = {
        title:"Audio Learning",
        intro: "Listen to spanish and learn along the way #{session[:loggedin_user]}!"
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
        title:"Visual Learning",
        intro:"Here you will learn with a little help from images and other visual media #{session[:loggedin_user]}!"
    }
    return slim(:swedish, locals:{key:visual_learning})
end

get('/swedish/text') do
    text_learning = {
        title:"Text Learning",
        intro: "Read spanish text and learn along the way #{session[:loggedin_user]}!"
    }
    return slim(:swedish, locals:{key:text_learning})
end

get('/swedish/audio') do
    audio_learning = {
        title:"Audio Learning",
        intro:"Listen to spanish and learn along the way #{session[:loggedin_user]}!"
    }
    return slim(:swedish, locals:{key:audio_learning})
end

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

    if params["right"] == "on" && params["right2"] == "on" && params["wrong"] != "on" && params["text1"].downcase == "hi" && params["text2"].downcase == "friend" && params["text3"].downcase == "rabbit" && params["text3"].downcase == "hamburguesa"
        session[:quiz_result] = true
    else
        session[:quiz_result] = false
    end

    redirect('/quiz')
end

get('/unlessyoueatthefleshofthesonofmananddrinkhisblood') do
    "<img src='https://gottebiten.se/media/catalog/product/cache/image/1000x1320/e9c3970ab036de70892d86c6d221abfe/7/3/7310070766113.jpg' alt='THE ENEMY OF GOD'>"
end
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
    session[:reg_error] = nil
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

get('/spanska') do
   return slim(:spanska)
end

get('/teori_spanska/visual') do
    visual_learning = {
        title:"Visual Learning"
    }
    return slim(:teori_spanska, locals:{key:visual_learning})
end

get('/teori_spanska/text') do
    text_learning = {
        title:"Text Learning"
    }
    return slim(:teori_spanska, locals:{key:text_learning})
end

get('/teori_spanska/audio') do
    audio_learning = {
        title:"Audio Learning"
    }
    return slim(:teori_spanska, locals:{key:audio_learning})
end

get('/svenska') do
    return slim(:svenska)
end

get('/teori_svenska/visual') do
    visual_learning = {
        title:"Visual Learning"
    }
    return slim(:teori_svenska, locals:{key:visual_learning})
end

get('/teori_svenska/text') do
    text_learning = {
        title:"Text Learning"
    }
    return slim(:teori_svenska, locals:{key:text_learning})
end

get('/teori_svenska/audio') do
    audio_learning = {
        title:"Audio Learning"
    }
    return slim(:teori_svenska, locals:{key:audio_learning})
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
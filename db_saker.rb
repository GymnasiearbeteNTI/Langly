require 'sinatra'
require 'slim'
require 'sqlite3'
require 'bcrypt'

enable :sessions

db = SQLite3::Database.new('db/db.db')
db.results_as_hash = true

def registerfunc()
    db = SQLite3::Database.new('db/db.db')
    db.results_as_hash = true
    uname = params["reg_username"]
    pword = BCrypt::Password.create(params["reg_password"])

    begin
        db.execute('INSERT INTO users(Username, Password) VALUES(?, ?)', uname, pword)
    rescue
        session[:reg_error] = true
        redirect('/register')
    end

    session[:account_created] = "Account created successfully!"
    redirect('/login')
end

def loginfunc()
    db = SQLite3::Database.new('db/db.db')
    db.results_as_hash = true

    loginuname = params["log_username"]
    loginpword = params["log_password"]

    begin
        existance_check_name = db.execute("SELECT Username FROM users WHERE Username =(?)", params["log_username"])
        existance_check_pass = db.execute("SELECT Password FROM users WHERE Username  =(?)", params["log_username"])

        if BCrypt::Password.new(existance_check_pass[0][0]) != loginpword
            session[:log_error] = "Password error, the password was not correct :/"
            redirect('/login')
        else
            session[:loggedin_user] = existance_check_name[0][0]
            redirect('/courses')
        end
    rescue
        session[:log_error] = "Username error, this username does not exist. Please check your spelling or make an account"
        redirect('/login')
    end
end
require 'sinatra'
require 'slim'

get ('/') do
    return slim(:homepage)
end

get ('/lektioner') do
    return slim(:lessons)
end

get ('/om_oss') do
    return slim(:om_oss)
end

get ('/login') do
    return slim(:login)
end

get('/lektioner/:user') do |user|
    important_data = [user,"blomquist","gurka"]

    x = {
        name:important_data[0],
        lname:important_data[1],
        favfood:important_data[2]
    }
    "<h1>Välkommen till sidan #{x}!</h1>"
    return slim(:lessons, locals:{key:x})
end
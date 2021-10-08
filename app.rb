require 'sinatra'
require 'slim'

get ('/') do
    slim(:homepage)
end

get ('/lektioner') do
    slim(:lessons)
end

get ('/om-oss') do
    File.read('public/om_oss.html')
end

get ('/login') do
    File.read('public/login.html')
end
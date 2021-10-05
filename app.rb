require 'sinatra'

get ('/') do
    File.read('public/index.html')
end

get ('/lektioner') do
    File.read('public/lektioner.html')
end

get ('/om-oss') do
    File.read('public/om_oss.html')
end

get ('/login') do
    File.read('public/login.html')
end
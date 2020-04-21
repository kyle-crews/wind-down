class UsersController < ApplicationController
    get '/users' do
        erb :users
    end
end
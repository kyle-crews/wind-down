class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
            erb :'users/create_user', :layout => :'not_logged_in_layout'
        else
            redirect_to_home_page
        end
    end
end
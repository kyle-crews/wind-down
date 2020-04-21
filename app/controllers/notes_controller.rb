class NotesController < ApplicationController
    get '/notes' do
        erb :notes
    end
end
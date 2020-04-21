class User < ActiveRecord::Base
    has_many :tasks
    has_many :notes
    has_secure_password
end
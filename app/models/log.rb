class Log < ActiveRecord::Base
    include Quantifiable::InstanceMethods

    belongs_to :user
end
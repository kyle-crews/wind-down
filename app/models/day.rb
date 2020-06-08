class Day < ActiveRecord::Base

  include Quantifiable::InstanceMethods

  has_many :logs, :dependent => :destroy
  belongs_to :user

end

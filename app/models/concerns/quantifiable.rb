class Quantifiable

  module InstanceMethods

    def total_accomplishment
      self.logs.collect {|log| log.accomplishment}.sum
    end

    def logs_sort_by_date
      self.logs.sort_by {|log| log[:date]}.reverse
    end
  end

end

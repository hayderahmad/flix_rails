class Movie < ApplicationRecord
    def self.released
        where("released_on < ?", Time.now).order("released_on desc")
    end
   
end

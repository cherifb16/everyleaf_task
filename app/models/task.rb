class Task < ApplicationRecord
    validates :name,    length: { in: 1..140 }
    validates :name,:details,:state,:priority,:end_date,presence: true
    
end

    

class Task < ApplicationRecord
    validates :name,    length: { in: 1..140 }
    validates :name,:details,:state,:priority,:end_date,presence: true
    paginates_per 2
    belongs_to :user

    has_many :tasks_labels, dependent: :destroy
    has_many :labels, :through => :tasks_labels

    accepts_nested_attributes_for :tasks_labels, :reject_if => proc { |a| 
     a['label_id'].blank? }
    accepts_nested_attributes_for :labels
    def self.search(term,term1)
        if term
          where('name LIKE ?', "%#{term}%")
        elsif term1
          where('name LIKE ?', "%#{term1}%")
        else
          order('created_at desc')
        end
    end
    
    def self.order_list(sort_order)
        if sort_order == "name"
          order(name: :desc)
        elsif sort_order == "end_date"
          order(end_date: :desc)
        elsif sort_order == "priority"
          order(priority: :asc)
        else
          order(created_at: :desc)
        end
    end
    
end

    

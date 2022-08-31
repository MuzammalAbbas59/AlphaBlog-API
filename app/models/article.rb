class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: {minimum:4, maximum:20}
    validates :description, presence: true, length: {minimum:14, maximum:200}
end

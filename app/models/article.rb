class Article < ApplicationRecord
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum:4, maximum:20}
    validates :description, presence: true, length: {minimum:14, maximum:200}
end

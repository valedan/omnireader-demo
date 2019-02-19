class Story < ApplicationRecord
  has_many :chapters, dependent: :destroy
end

# frozen_string_literal: true

class Story < ApplicationRecord
  has_many :chapters, dependent: :destroy
end

# frozen_string_literal: true

class Chapter < ApplicationRecord
  belongs_to :story
end

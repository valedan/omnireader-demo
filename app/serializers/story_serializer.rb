# frozen_string_literal: true

class StorySerializer
  include FastJsonapi::ObjectSerializer

  set_type :story
  attributes :canonical_url, :title, :author, :details
  has_many :chapters
end

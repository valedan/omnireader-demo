# frozen_string_literal: true

class StoryFetcher < ApplicationService
  def initialize(story_url)
    @story_url = story_url
  end

  def call
    Strategy.for(@story_url).get_story
  end
end

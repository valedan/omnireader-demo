# frozen_string_literal: true

class ChapterFetcher < ApplicationService
  def initialize(chapter_url)
    @chapter_url = chapter_url
  end

  def call
    Strategy.for(@chapter_url).get_chapter
  end
end

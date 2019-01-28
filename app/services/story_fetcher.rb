class StoryFetcher < ApplicationService
  def initialize(story_url)
    @story_url = story_url
    @strategy = Strategy.for(story_url)
  end

  def call
    retrieve_page
    parse_page
  end

  private
  
  def retrieve_page
    @page = Scraper.get_page(@story_url)
  end

  def parse_page
    {
      story_title: @page.at_css('#profile_top .xcontrast_txt')
    }
    byebug
    puts ''
  end
end

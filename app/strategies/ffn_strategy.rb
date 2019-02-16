class FFNStrategy < Strategy
  register_for /(fictionpress\.com|fanfiction\.net)\/s\/\d+\//

  def get_story_info
    @page = Scraper.fetch(@url)
    parse_story_info
  end

  def get_chapter_info

  end

  private

  def parse_story_info
    {
      story_title: @page.at_css('#profile_top .xcontrast_txt'),
      author_name: @page.at_css("//a[starts-with(@href, '/u/')]"),
      story_description: @page.at_css("#profile_top div.xcontrast_txt"),
      story_information: @page.at_css("#profile_top span.xgray.xcontrast_txt"),
      chapter_list: parse_chapter_list
    }
  end

  def parse_chapter_list
    @page.css("#chap_select option").map do |option|
      {
        title: option.text,
        url: 
      }
    end
  end
end

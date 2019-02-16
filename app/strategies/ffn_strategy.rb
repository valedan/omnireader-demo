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
      story_title: @page.at_css('#profile_top .xcontrast_txt').text.strip,
      author_name: @page.xpath("//a[starts-with(@href, '/u/')]").first.text.strip,
      story_description: @page.at_css("#profile_top div.xcontrast_txt").text,
      story_information: @page.at_css("#profile_top span.xgray.xcontrast_txt").text.gsub(/\s{2,}/, ' ').strip,
      chapter_list: parse_chapter_list
    }
  end

  def parse_chapter_list
    @page.at_css("#chap_select").css("option").map do |option|
      url = @page.at('[@rel="canonical"]')['href']
      url = "https:" + url unless url.start_with?('http')
      {
        title: option.text,
        url: url.gsub(/\/s\/\d+\/\d+/) do |match|
          parts = match.split('/')
          parts[-1] = option['value']
          parts.join('/')
        end
      }
    end
  end
end

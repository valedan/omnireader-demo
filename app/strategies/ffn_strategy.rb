# frozen_string_literal: true

class FFNStrategy < Strategy
  def get_story
    @page = Scraper.fetch(@url)
    parse_story
  end

  def get_chapter
    @page = Scraper.fetch(@url)
    parse_chapter
  end

  private

  def parse_story
    {
      story: {
        title: @page.at_css('#profile_top .xcontrast_txt').text.strip,
        author: @page.xpath("//a[starts-with(@href, '/u/')]").first.text.strip,
        details: {
          story_description: @page.at_css('#profile_top div.xcontrast_txt').text,
          story_information: @page.at_css('#profile_top span.xgray.xcontrast_txt').text.gsub(/\s{2,}/, ' ').strip
        }
      },

      chapters: parse_chapter_list
    }
  end

  def parse_chapter
    {
      content: @page.at_css('#storytext').text
    }
  end

  def parse_chapter_list
    @page.at_css('#chap_select').css('option').map do |option|
      url = @page.at('[@rel="canonical"]')['href']
      url = 'https:' + url unless url.start_with?('http')
      {
        title: option.text,
        url: url.gsub(%r{/s/\d+/\d+}) do |match|
          parts = match.split('/')
          parts[-1] = option['value']
          parts.join('/')
        end
      }
    end
  end
end

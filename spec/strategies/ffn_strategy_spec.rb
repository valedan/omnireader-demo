require 'rails_helper'

describe FFNStrategy, type: :strategy do
  let(:story_url) {'https://www.fanfiction.net/s/5782108/1/Harry-Potter-and-the-Methods-of-Rationality'}
  let(:story_page) {file_fixture('external_web_pages/ffn_hpmor.html').read}

  describe "#get_story" do
    before do
      @page_stub = stub_request(:get, story_url)
                    .to_return(body: story_page, headers: {'Content-Type' => 'text/html; charset=UTF-8'})
      @result = StoryFetcher.call(story_url)
    end
  
    it 'retrieves the url provided' do
      expect(@page_stub).to have_been_requested
    end
  
    it 'parses the page based on target data and returns json data' do
      expect(@result).to eq({
        story_title: 'Harry Potter and the Methods of Rationality',
        author_name: 'Less Wrong',
        story_description: 'Petunia married a biochemist, and Harry grew up reading science and science fiction. Then came the Hogwarts letter, and a world of intriguing new possibilities to exploit. And new friends, like Hermione Granger, and Professor McGonagall, and Professor Quirrell... COMPLETE.',
        story_information: 'Rated: Fiction T - English - Drama/Humor - Harry P., Hermione G. - Chapters: 122 - Words: 661,619 - Reviews: 34,596 - Favs: 23,879 - Follows: 17,999 - Updated: 3/14/2015 - Published: 2/28/2010 - Status: Complete - id: 5782108',
        chapter_list: [
          {
            title: '1. A Day of Very Low Probability',
            url: 'https://www.fanfiction.net/s/5782108/1/Harry-Potter-and-the-Methods-of-Rationality'
          },
          {
            title: '2. Everything I Believe Is False',
            url: 'https://www.fanfiction.net/s/5782108/2/Harry-Potter-and-the-Methods-of-Rationality'
          },
          {
            title: '3. Comparing Reality To Its Alternatives',
            url: 'https://www.fanfiction.net/s/5782108/3/Harry-Potter-and-the-Methods-of-Rationality'
          }
        ]
      })
    end
  end

  describe "#get_chapter" do
    before do
      @page_stub = stub_request(:get, story_url)
                    .to_return(body: story_page, headers: {'Content-Type' => 'text/html; charset=UTF-8'})
      @result = ChapterFetcher.call(story_url)
    end
  
    it 'retrieves the url provided' do
      expect(@page_stub).to have_been_requested
    end
  
    it 'parses the page based on target data and returns json data' do
      expect(@result).to eq({
        content: Nokogiri::HTML(story_page).at_css('#storytext').text
      })
    end
  end

  
end

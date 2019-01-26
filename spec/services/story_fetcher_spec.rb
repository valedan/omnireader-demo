require 'rails_helper'

describe StoryFetcher, type: :service do
  let(:target_data) {create(:target_data, domains: ['www.fanfiction.net'])}
  let(:story_url) {'https://www.fanfiction.net/s/5782108/1/Harry-Potter-and-the-Methods-of-Rationality'}
  let(:story_page) {file_fixture('external_web_pages/ffn_hpmor.html').read}

  before do
    @page_stub = stub_request(:get, story_url).to_return(story_page)
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
      story_information: 'Rated: Fiction T - English - Drama/Humor - Harry P., Hermione G. - Chapters: 122 - Words: 661,619 - Reviews: 34,596 - Favs: 23,879 - Follows: 17,999 - Updated: Mar 14, 2015 - Published: Feb 28, 2010 - Status: Complete - id: 5782108',
      chapter_list: [
        '1. A Day of Very Low Probability',
        '2. Everything I Believe Is False',
        '3. Comparing Reality To Its Alternatives'
      ]
    })
  end
end

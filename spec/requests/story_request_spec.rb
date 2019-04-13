# frozen_string_literal: true

require 'rails_helper'

describe 'Story Endpoints', type: :request do
  describe 'GET Story' do
    context 'When story exists' do
      let!(:target_story) { create(:story_with_chapters, chapter_count: 4) }
      let!(:other_story)  { create(:story_with_chapters) }

      before { get "/stories/#{target_story.id}" }

      it 'returns a 200' do
        expect(response).to have_http_status 200
      end

      it 'returns serialized story' do
        expect(json_response.data.attributes.title).to eq target_story.title
        expect(json_response.data.attributes.author).to eq target_story.author
      end

      it 'returns list of chapters for the story' do
        expect(json_response.data.relationships.chapters.data.count)
          .to eq target_story.chapters.count
      end
    end

    context 'When story does not exist' do
      it 'returns a 404' do
        get '/stories/1'
        expect(response).to have_http_status 404
      end
    end
  end

  describe 'GET Stories' do
    let!(:stories) { create_list(:story_with_chapters, 4) }

    before { get '/stories' }

    it 'returns 200' do
      expect(response).to have_http_status 200
    end

    it 'returns story details for all stories' do
      expect(json_response.data.count).to eq Story.count
      expect(json_response.data.map { |story| story.attributes.title })
        .to match_array(Story.pluck(:title))
    end

    it 'returns chapter list for each story' do
      first_story = json_response.data.first
      expect(first_story.relationships.chapters.data.map(&:id).map(&:to_i))
        .to match_array(Story.find(first_story.id).chapters.pluck(:id))
    end
  end

  describe 'POST Stories' do
    context 'When there is a strategy for requested URL' do
      let(:story_url)  { 'https://www.fanfiction.net/s/5782108/1/Harry-Potter-and-the-Methods-of-Rationality' }
      let(:story_page) { file_fixture('external_web_pages/ffn_hpmor.html').read }

      before do
        @page_stub = stub_request(:get, story_url)
                     .to_return(body: story_page, headers: { 'Content-Type' => 'text/html; charset=UTF-8' })
        post '/stories', params: { story_url: story_url }
      end

      it 'fetches story from url' do
        expect(@page_stub).to have_been_requested
        expect(Story.count).to eq 1
        expect(Chapter.count).to eq 3
      end

      it 'returns new story' do
        expect(json_response.data.attributes.title).to eq 'Harry Potter and the Methods of Rationality'
        expect(json_response.data.relationships.chapters.data.count)
          .to eq 3
      end
    end

    context 'When there is no strategy for requested URL' do
      let(:story_url) { 'https://www.google.com' }

      before do
        post '/stories', params: { story_url: story_url }
      end

      it 'returns a 422'
    end
  end

  describe 'DELETE Story' do
    context 'When story exists' do
      let!(:story)  { create(:story_with_chapters) }

      before { delete "/stories/#{story.id}" }

      it 'deletes story' do
        expect(Story.count).to eq 0
      end

      it 'returns 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the deleted story' do
        expect(json_response.data.attributes.title).to eq story.title
      end
    end

    context 'When story does not exist' do
      it 'returns 404' do
        delete '/stories/1'
        expect(response).to have_http_status 404
      end
    end
  end
end

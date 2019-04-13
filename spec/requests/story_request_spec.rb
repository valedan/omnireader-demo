# frozen_string_literal: true

require 'rails_helper'
include Helpers::Requests

describe 'Story Endpoints', type: :request do
  describe 'GET Story' do
    # data: 2 stories with chapters

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
        expect(json_response.data.relationships.chapters.data.count).to eq 4
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
    # data: 2+ stories with chapters
    it 'returns story details for all stories'
  end

  describe 'POST Stories' do
    # data: none
    it 'fetches story from url'
    it 'returns new story'
  end

  describe 'DELETE Story' do
    # data: 1 story with chapters
    it 'deletes story'
  end
end

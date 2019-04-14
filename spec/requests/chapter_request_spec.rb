# frozen_string_literal: true

require 'rails_helper'

describe 'Chapter Endpoints', type: :request do
  describe 'GET Chapter' do
    context 'When chapter exists' do
      let!(:story)         { create(:story_with_chapters, chapter_count: 3) }
      let(:target_chapter) { story.chapters.second }
      let(:page)           { file_fixture('external_web_pages/ffn_hpmor.html').read }

      let!(:chapter_request_stub) do
        stub_request(:get, target_chapter.url)
          .to_return(body: page, headers: { 'Content-Type' => 'text/html; charset=UTF-8' })
      end

      before do
        get "/stories/#{story.id}/chapters/#{target_chapter.id}"
      end

      it 'returns a 200' do
        expect(response).to have_http_status :ok
      end

      it 'fetches chapter content from url' do
        expect(chapter_request_stub).to have_been_requested
      end

      it 'returns serialized chapter including content' do
        expect(json_response.data.attributes.title).to eq target_chapter.title
        expect(json_response.data.attributes.content)
          .to eq Nokogiri::HTML(page).at_css('#storytext').text
      end
    end

    context 'When chapter does not exist' do
      let!(:story) { create(:story) }

      before do
        get "/stories/#{story.id}/chapters/100"
      end

      it 'returns a 404' do
        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'PUT Chapter' do
    context 'When chapter exists' do
      let!(:story)         { create(:story_with_chapters, chapter_count: 3) }
      let(:target_chapter) { story.chapters.second }

      context 'When updating a permitted attribute' do
        let(:new_progress) { 42 }
        let(:allowed_params) { { attributes: { progress: new_progress } } }

        before do
          patch "/stories/#{story.id}/chapters/#{target_chapter.id}", params: allowed_params
        end

        it 'updates the chapter' do
          expect(target_chapter.reload.progress).to eq new_progress
        end

        it 'returns updated chapter' do
          expect(json_response.data.attributes.progress).to eq new_progress
        end

        it 'returns 200' do
          expect(response).to have_http_status :ok
        end
      end

      context 'When updating a nonpermitted attribute' do
        let(:forbidden_params) { { attributes: { title: 'New Title' } } }
        let(:original_title)   { target_chapter.title }

        before do
          patch "/stories/#{story.id}/chapters/#{target_chapter.id}", params: forbidden_params
        end

        it 'does not update the chapter' do
          expect(target_chapter.reload.title).to eq original_title
        end

        it 'returns an error' do
          expect(json_response.errors.first.title).to eq 'ActionController::UnpermittedParameters'
          expect(json_response.errors.first.detail).to include('title')
        end

        it 'returns 400' do
          expect(response).to have_http_status :bad_request
        end
      end
    end

    context 'When chapter does not exist' do
      let!(:story) { create(:story) }

      before do
        get "/stories/#{story.id}/chapters/100"
      end

      it 'returns a 404' do
        expect(response).to have_http_status :not_found
      end
    end
  end
end

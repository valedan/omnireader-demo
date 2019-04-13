# frozen_string_literal: true

class StoriesController < ApplicationController
  def index
    @stories = Story.all
    render json: StorySerializer.new(@stories).serializable_hash
  end

  def show
    @story = Story.find(params[:id])
    render json: StorySerializer.new(@story).serializable_hash
  end

  def create
    story_data = StoryFetcher.call(params[:story_url])
    @story = Story.create!(story_data[:story])
    story_data[:chapters].each { |chapter| Chapter.create!(**chapter, story: @story) }
    render json: StorySerializer.new(@story).serializable_hash
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy!
    render json: StorySerializer.new(@story).serializable_hash
  end
end

# frozen_string_literal: true

class StoriesController < ApplicationController
  def index
    @stories = Story.all
    options = { include: [:chapters] } if params[:include] == 'chapters'
    render json: StorySerializer.new(@stories, options || {}).serializable_hash
  end

  def show
    @story = Story.find(params[:id])
    options = { include: [:chapters] }
    render json: StorySerializer.new(@story, options).serializable_hash
  end

  def create
    if Strategy.for(params[:story_url])
      story_data = StoryFetcher.call(params[:story_url])
      @story = Story.create!(story_data[:story])
      story_data[:chapters].each { |chapter| Chapter.create!(**chapter, story: @story) }
      render json: StorySerializer.new(@story).serializable_hash
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy!
    render json: StorySerializer.new(@story).serializable_hash
  end
end

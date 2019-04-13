# frozen_string_literal: true

class StoriesController < ApplicationController
  def index; end

  def show
    @story = Story.find(params[:id])
    render json: StorySerializer.new(@story).serializable_hash
  end

  def create; end

  def delete; end
end

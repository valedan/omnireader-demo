# frozen_string_literal: true

class ChaptersController < ApplicationController
  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  def show
    @chapter = Chapter.find(params[:id])
    content = ChapterFetcher.call(@chapter.url)
    render json: ChapterSerializer.new(@chapter, params: content).serializable_hash
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update!(chapter_params)
    render json: ChapterSerializer.new(@chapter).serializable_hash
  end

  private

  def chapter_params
    params.require(:attributes).permit(:progress)
  end
end

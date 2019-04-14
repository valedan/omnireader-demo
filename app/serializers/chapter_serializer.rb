# frozen_string_literal: true

class ChapterSerializer
  include FastJsonapi::ObjectSerializer

  set_type :chapter
  attributes :title, :url, :number, :progress
  attribute :content, if: proc { |_, params| !!params[:content] } do |_, params|
    params[:content]
  end
  belongs_to :story
end

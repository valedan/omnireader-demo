require 'rails_helper'

describe "Story Endpoints", type: :request do

  describe "GET Story" do
    # data: 2 stories with chapters
    it "returns story detail and chapter list for story" do
      get "stories/42"
    end
  end

  describe "GET Stories" do
    #data: 2+ stories with chapters
    it "returns story details for all stories"
  end

  describe "POST Stories" do
    #data: none
    it "fetches story from url"
    it "returns new story"
  end

  describe "DELETE Story" do
    # data: 1 story with chapters
    it "deletes story"
  end
end

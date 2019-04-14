# frozen_string_literal: true

FactoryBot.define do
  factory :chapter do
    progress { rand(100_000) }
    title { Faker::Book.title }
    url { "https://www.fanfiction.net/s/#{rand(100_000)}/#{number}/#{title.tr(' ', '-')}" }
    story { create(:story) }
    sequence(:number, 1)
  end
end

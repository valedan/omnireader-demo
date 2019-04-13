# frozen_string_literal: true

FactoryBot.define do
  factory :chapter do
    progress { rand(100_000) }
    title { Faker::Book.title }
    sequence(:number, 1)
    url { "https://www.fanfiction.net/s/#{rand(100_000)}/#{number}/#{title.tr(' ', '-')}" }
  end
end

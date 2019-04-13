# frozen_string_literal: true

FactoryBot.define do
  factory :story do
    canonical_url { "https://www.fanfiction.net/s/#{rand(100_000)}/1/" }
    title { Faker::Book.title }
    author { Faker::Book.author }
    details do
      {
        story_description: Faker::Lorem.paragraph,
        story_information: Faker::Lorem.paragraph
      }
    end

    factory :story_with_chapters do
      transient do
        chapter_count { 2 }
      end

      after(:create) do |story, evaluator|
        create_list(:chapter, evaluator.chapter_count, story: story)
      end
    end
  end
end

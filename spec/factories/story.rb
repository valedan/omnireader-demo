FactoryBot.define do
  factory :story do
    canonical_url {"https://www.fanfiction.net/s/#{rand(100000)}/1/"}
    details do
      {
        story_title: Faker::Book.title,
        author_name: Faker::Book.author,
        story_description: Faker::Lorem.paragraph,
        story_information: Faker::Lorem.paragraph
      }
      # with chapters
      # transietnt 
      # https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md#Associations
    end
  end
end

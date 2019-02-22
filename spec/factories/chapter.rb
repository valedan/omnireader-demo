FactoryBot.define do
  factory :chapter do
    progress {rand(100000)}
    title {Faker::Book.title}
    sequence(:number, 1)
    url {"https://www.fanfiction.net/s/#{rand(100000)}/#{number}/#{title.join('-')}"}
  end
end

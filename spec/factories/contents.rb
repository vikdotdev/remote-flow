FactoryBot.define do
  factory :content, class: 'Content' do
    title { Faker::Company.industry }
    organization

    trait :video do
      type { 'Video' }
      video_url { 'https://www.youtube.com/watch?v=Gzj723LkRJY' }
    end

    trait :gallery do
      type { 'Gallery' }
    end

    trait :page do
      type { 'Page' }
      title { Faker::Company.industry }
      body { "<h4>#{ Faker::Lorem.sentence(word_count: 5) }</h4>" + Faker::Lorem.paragraphs(number: 4).map{|pr| "<p>#{pr}</p>" }.join + "<b>Author: #{ Faker::Name.name }<b>" }
    end

    factory :gallery, class: 'Gallery', traits: [:gallery]
    factory :video, class: 'Video', traits: [:video]
    factory :page, class: 'Page', traits: [:page]
  end
end

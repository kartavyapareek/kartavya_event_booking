FactoryBot.define do
  factory :event do
    name { "Sample Event" }
    description { "Event description" }
    location { "Event location" }
    date_time { Time.now + 1.day }
    total_tickets { 10 }
    available_tickets { 10 }
    association :user
  end
end

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name: name, separators: ['-']) }
    password { Faker::Internet.password }
    password_confirmation { password }
  end

  factory :party do
    duration { Faker::Number.between(from: 60, to: 180) }
    party_date { Faker::Date.between(from: Date.today, to: 5.days.from_now) }
    party_time { Time.current }
  end
end

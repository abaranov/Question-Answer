FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "1person#{n}@example.com" }
    password "FooBar8"
    password_confirmation "FooBar8"
  end

  factory :admin, class: User do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password "Admin8"
    password_confirmation "Admin8"
    role "admin"
  end

  factory :question do
    title "title"
    body "question text"
    rate "0"
    user  FactoryGirl.create(:user)
  end

  factory :answer do
    body "answer text"
    question FactoryGirl.create(:question)
    user  FactoryGirl.create(:user)
  end
end
FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "FooBar8"
    password_confirmation "FooBar8"
  end

  factory :admin, class: User do
    sequence :email do |n|
      "admin#{n}@example.com"
    end
    password "Admin8"
    password_confirmation "Admin8"
    role "admin"
  end

  factory :question do
    title "title"
    body "text"
    rate "0"
    user  FactoryGirl.create(:user)
  end
end
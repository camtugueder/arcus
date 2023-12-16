FactoryBot.define do
  factory :jwt_deny_list do
    jti { "MyString" }
    exp { "2023-12-16 15:14:25" }
  end
end

require 'faker'

FactoryGirl.define do
  factory :team do
    name "MyString"
    common_hours "MyString"
    student_id ""
  end
  factory :student do
    name { Faker::Name.name }
    time_zone { Faker::Address.time_zone }
    gatech_class "cs6300"
    gatechuname { Faker::Internet.user_name }
    gatechid { Faker::Number.number(9) }
    email { Faker::Internet.email }
    learning_objectives { Faker::Hipster.paragraph(2) }
    preferred_tools { Faker::Beer.style }
    myers_briggs { [
      :ENFJ, :INFJ, :ENFP, :INFP,
      :INTJ, :ENTJ, :INTP, :ENTP,
      :ESFP, :ISFP, :ESFJ, :ISFJ,
      :ISTP, :ESTP, :ISTJ, :ESTJ,
                   ].sample }

    java_expertise { [:novice, :intermediate, :expert].sample }
    week_preferred { [:daytime, :afternoon, :evening, :allday, :notfree].sample }
    weekend_preferred { [:daytime, :afternoon, :evening, :allday].sample }

  end
end

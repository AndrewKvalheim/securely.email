# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    slug 'Example'
    fingerprint '81A46DCA7018FABFC72BB787253A0338239BC6E9'

    factory :colliding_identity, aliases: [:other_identity] do
      fingerprint 'D00436A90C4BD12002020A3C37E1C17570096AD1'
    end

    factory :unconnected_identity do
      fingerprint '3A87FE0943A39B1C196471AEA25BB96F66778BBD'
    end

    factory :nonexistent_identity do
      fingerprint 'A4E2B0C325633D2120BEC0C6CD9E545436171BC6'
    end
  end
end

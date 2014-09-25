# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    slug 'Example'
    fingerprint '81A46DCA7018FABFC72BB787253A0338239BC6E9'

    factory :identity_with_id_collision, aliases: [:other_identity] do
      fingerprint 'D00436A90C4BD12002020A3C37E1C17570096AD1'
    end

    factory :nonexistent_identity do
      fingerprint 'A4E2B0C325633D2120BEC0C6CD9E545436171BC6'
    end
  end
end

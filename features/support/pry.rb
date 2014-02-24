require 'pry'

After( '@pry' ) do |scenario|
  binding.pry if scenario.failed?
end

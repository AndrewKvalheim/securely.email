require 'ostruct'

# Success status
class Success < OpenStruct
  def success?
    true
  end
end

# Failure status
class Failure < OpenStruct
  def success?
    false
  end
end

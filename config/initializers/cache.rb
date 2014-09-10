unless Rails.env.production?
  Rails.cache.clear
end

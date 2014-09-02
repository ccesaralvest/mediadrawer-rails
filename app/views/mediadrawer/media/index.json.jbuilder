json.array! @media_files do |media|
  json.extract! media, :id, :name, :alt, :url, :mime_type
  json.resource_url media_path(media)
end
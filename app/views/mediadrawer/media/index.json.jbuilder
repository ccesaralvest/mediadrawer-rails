json.array! @media_files do |media|
  json.extract! media, :id, :name, :alt, :url, :mime_type
  Mediadrawer.config['sizes'].each do |size_name, size|
    json.set! size_name, media.url_for(size_name)
  end
  json.resource_url media_path(media)
end
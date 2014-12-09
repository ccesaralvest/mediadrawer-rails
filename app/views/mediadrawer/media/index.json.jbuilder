json.cache! ['v1', @media_files.map(&:updated_at),  @folder.updated_at], expires_in: 1.week do
  json.array! @media_files do |media|
    json.extract! media, :id, :name, :alt, :url, :mime_type, :type
    if media.is_image?
      Mediadrawer.config['sizes'].each do |size_name, size|
        json.set! size_name, media.url_for(size_name)
      end
      json.sizes Mediadrawer.config['sizes']
    end
    json.resource_url media_path(media)
  end
end

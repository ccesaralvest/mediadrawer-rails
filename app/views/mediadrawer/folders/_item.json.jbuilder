json.id item.id
json.name item.name
json.path item.path
if @recursive == '1'
  json.children do
    json.partial! 'index', item: item
  end
else
  json.children []
end
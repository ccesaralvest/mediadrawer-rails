json.name item.name
if @recursive == '1'
  json.children do
    json.partial! 'index', item: item
  end
else
  json.children []
end
json.array!(item.children) do |child|
  json.partial! 'item', item: child
end
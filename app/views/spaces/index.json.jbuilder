json.array!(@spaces) do |space|
  json.extract! space, :name, :category, :address, :city, :state, :hours, :phone, :email, :website, :description, :dot_color
  json.url space_url(space, format: :json)
end

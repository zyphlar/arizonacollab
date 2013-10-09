json.array!(@spaces) do |space|
  json.extract! space, :name, :type, :address, :hours, :phone, :email, :website, :description
  json.url space_url(space, format: :json)
end

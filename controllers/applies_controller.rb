namespace '/api/v1' do
  get '/applies_read' do
    collection_to_api(Apply.read.all)
  end

  get '/applies_unread' do
    collection_to_api(Apply.unread.all)
  end
end

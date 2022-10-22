namespace '/api/v1' do
  get '/companies' do
    collection_to_api(DB[:companies].all)
  end
  get '/companies/:id' do
    collection_to_api(DB[:companies].where({id: params[:id]}).all)
  end
  get '/companies/:id/jobs' do
    collection_to_api(DB[:jobs].where({company_id: params[:id]}).all)
  end
  post '/companies' do
    id = DB[:companies].insert(name: params[:name], location: params[:location])

    collection_to_api(DB[:companies].where(:id => id).all)
  end
  post '/companies/:id' do
    DB[:companies].where(:id => params[:id]).update(name: params[:name], location: params[:location])

    collection_to_api(DB[:companies].where(:id => params[:id]).all)
  end
end



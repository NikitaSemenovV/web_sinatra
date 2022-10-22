namespace '/api/v1' do
  get '/jobs' do
    collection_to_api(DB[:jobs].all)
  end
  get '/jobs/:id' do
    collection_to_api(DB[:jobs].where({id: params[:id]}).all)
  end
  get '/jobs/:id/applies' do
    collection_to_api(DB[:applies].where({job_id: params[:id]}).all)
  end
  post '/jobs' do
    id = DB[:jobs].insert(name: params[:name], place: params[:place], company_id: params[:company_id])

    collection_to_api(DB[:jobs].where(:id => id).all)
  end
  post '/jobs/:id' do
    DB[:jobs].where(:id => params[:id]).update(name: params[:name], place: params[:place], company_id: params[:company_id])

    collection_to_api(DB[:jobs].where(:id => params[:id]).all)
  end
end


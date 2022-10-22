namespace '/api/v1' do
  get '/geeks/:id?' do
    if params[:id]
      collection_to_api(DB[:geeks].where({id: params[:id]}).all)
    else
      collection_to_api(DB[:geeks].all)
    end
  end

  get '/geeks/:id/applies' do
    collection_to_api(DB[:applies].where({geek_id: params[:id]}).all)
  end
  post '/geeks' do
    id = DB[:geeks].insert(name: params[:name], stack: params[:stack], resume: params[:resume])

    collection_to_api(DB[:geeks].where(:id => id).all)
  end
  post '/geeks/:id' do
    DB[:geeks].where(:id => params[:id]).update(name: params[:name], stack: params[:stack], resume: params[:resume])

    collection_to_api(DB[:geeks].where(:id => params[:id]).all)
  end
end


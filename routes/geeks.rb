namespace '/api/v1' do
  get '/geeks/:id?' do
    if params[:id]
      collection_to_api(Geek.where({id: params[:id]}).all)
    else
      collection_to_api(Geek.all)
    end
  end

  get '/geeks/:id/applies' do
    collection_to_api(Apply.where({geek_id: params[:id]}).all)
  end
  post '/geeks' do
    param :name, String, required: true
    param :stack, String, required: true
    param :resume, String, required: true

    geek = Geek.create({name: params[:name], stack: params[:stack], resume: params[:resume]})
    geek.values.to_json
  end
  post '/geeks/:id' do
    param :name, String
    param :stack, String
    param :resume, String
    one_of :name, :stack, :resume

    geeks = Geek.where(:id => params[:id])
    geeks.update(name: params[:name], stack: params[:stack], resume: params[:resume])

    collection_to_api(geeks.all)
  end

  delete '/geeks/:id' do
    geek = Geek.where(:id => params[:id]).first
    res = geek.values.to_json
    geek.delete

    res
  end
end


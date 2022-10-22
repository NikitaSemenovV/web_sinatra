namespace '/api/v1' do
  get '/jobs' do
    collection_to_api(Job.all)
  end
  get '/jobs/:id' do
    collection_to_api(Job.where({id: params[:id]}).all)
  end
  get '/jobs/:id/applies' do
    collection_to_api(Apply.where({job_id: params[:id]}).all)
  end
  post '/jobs' do
    param :name, String, required: true
    param :place, String, required: true
    param :company_id, Integer, required: true

    job = Job.create({name: params[:name], place: params[:place], company_id: params[:company_id]})

    job.values.to_json
  end
  put '/jobs/:id' do
    param :name, String
    param :place, String
    param :company_id, Integer
    one_of :name, :place, :company_id

    job = Job.where(:id => params[:id])
    job.update(name: params[:name], place: params[:place], company_id: params[:company_id])

    collection_to_api(job.all)
  end

  delete '/jobs/:id' do
    job = Job.where(:id => params[:id]).first
    res = job.values.to_json
    job.delete

    res
  end
end


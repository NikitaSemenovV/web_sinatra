namespace '/api/v1' do
  get '/companies' do
    companies = Company.all
    return collection_to_api(companies) if params.empty?
    if params['name']
      puts 'name'
      companies_all = Company.by_name(params['name'])
      if params['location']
        puts 'name + location'
        companies = Company.by_location(params['location'], companies_all) if companies_all != []
      else
        puts 'name NO location'
        companies = companies_all
      end
    else
      if params['location']
        puts 'location'
        companies = Company.by_location(params['location'])
      end
    end
    collection_to_api(companies)
  end

  get "/company_jobs" do
    Company.company_jobs(params[:name])
  end

  get '/companies/:id' do
    collection_to_api(Company.where({ id: params[:id] }).all)
  end

  get '/companies/:id/jobs' do
    collection_to_api(Job.where({ company_id: params[:id] }).all)
  end

  post '/companies' do
    param :name, String, required: true
    param :location, String, required: true
    company = Company.create({name: params[:name], location: params[:location]})

    company.values.to_json
  end

  post '/companies/:id' do
    param :name, String
    param :location, String
    one_of :name, :location

    companies = Company.where(:id => params[:id])
    companies.update(name: params[:name], location: params[:location])

    collection_to_api(companies.all)
  end

  delete '/companies/:id' do
    companies = Company.where(:id => params[:id]).first
    res = companies.values.to_json
    companies.delete

    res
  end
end



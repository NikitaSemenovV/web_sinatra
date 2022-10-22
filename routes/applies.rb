namespace '/api/v1' do
  post '/apply' do
    apply = Apply.create({geek_id: params[:geek_id], job_id: params[:job_id]})

    apply.values.to_json
  end
end




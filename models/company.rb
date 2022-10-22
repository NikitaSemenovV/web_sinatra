class Company < Sequel::Model(:companies)
  one_to_many  :jobs

  def self.by_name(name)
    res = []
    res = where(name: /#{name}/i) if name
    puts "In by_name dataset mod: res = #{res.inspect}"
    # res.empty? ? [].to_json : collection_to_api(res)
    res.empty? ? [] : res
  end

  def self.by_location(location)
    puts 'In by_location dataset mod'
    where(location: /#{location}/i) if location
  end

  def self.company_jobs(name)
    company = Company.by_name(name)#[:id]
    company_id = company.map(:id)[0]
    company_id.nil? ? [].to_json : company_id.to_json
    company_jobs = Job.company_jobs(company_id).all.map {|job| job.to_hash}
    company_jobs.empty? ? [].to_json : collection_to_api(company_jobs)
  end
end


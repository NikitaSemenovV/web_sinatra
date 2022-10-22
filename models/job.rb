class Job < Sequel::Model(:jobs)
  many_to_one :company

  def self.company_jobs(id)
    where(company_id: id)
  end
end


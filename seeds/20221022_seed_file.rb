Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    puts 'Start truncate for all models'
    $db[:applies].truncate(cascade: true, restart: true)
    $db[:geeks].truncate(cascade: true, restart: true)
    $db[:jobs].truncate(cascade: true, restart: true)
    $db[:companies].truncate(cascade: true, restart: true)
    puts 'Models truncated'
    puts 'Start to write models'

    Company.create({name: "8base", location: "Майами"})
    Company.create({name: "Google", location: "Москва"})
    Company.create({name: "EPAM", location: "Санкт-Петербург"})
    puts 'Company created'

    Job.create({name: "QA Engineer", place: "Москва", company_id: Company.where(name:"8base").first[:id]})
    Job.create({name: "Front-end", place: "Москва", company_id: Company.where(name:"EPAM").first[:id]})
    Job.create({name: "Back-end", place: "Москва", company_id: Company.where(name:"EPAM").first[:id]})
    Job.create({name: "DevOps", place: "Москва", company_id: Company.where(name:"Google").first[:id]})
    puts 'Job created'

    Geek.create({name: "Никита", stack: "123", resume: "1111"})
    Geek.create({name: "Михаил", stack: "123", resume: "1111"})
    Geek.create({name: "Екатерина", stack: "123", resume: "1111"})
    puts 'Geek created'

    Apply.create({job_id: 1, geek_id: 1})
    Apply.create({job_id: 1, geek_id: 2})
    Apply.create({job_id: 2, geek_id: 2})
    puts 'Apply created'

    puts 'Models seeded'
  end
end

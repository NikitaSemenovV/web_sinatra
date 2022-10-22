class Apply < Sequel::Model(:applies)
  many_to_one  :jobs
  many_to_one :geeks

  def self.read
    where(read: true)
  end
  def self.unread
    where(read: false)
  end
end


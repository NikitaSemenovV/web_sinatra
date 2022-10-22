class Geek < Sequel::Model(:geeks)
  one_to_many  :applies
end


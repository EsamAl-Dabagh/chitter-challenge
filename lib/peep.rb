require 'pg'

class Peep 

  def self.all
    connection = select_database

    peeps = connection.exec("SELECT * FROM peeps ORDER BY id DESC")

    peeps.map do |peep|
      peep["body"]
    end
  end

  def self.add(peep)
    connection = select_database

    connection.exec("INSERT INTO peeps (body) VALUES ('#{peep}');")
  end

  def self.select_database
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'chitter_test')
    else
      PG.connect(dbname: 'chitter')
    end
  end

end

class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def owner
    #returns the owner of that restaurant
    sql = <<-SQL
      SELECT * FROM owners WHERE id = ?
    SQL
    Customer.db.execute(sql,self.owner_id) #owner_id is defined
  end

  def self.db
    DB[:conn]
  end

end

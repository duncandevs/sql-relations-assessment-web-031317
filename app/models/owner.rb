class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    # returns all restaurants belonging to that owner
    # owner.restaurants
    sql = <<-SQL
      SELECT * FROM restaurants WHERE owner_id = ?
    SQL
    Customer.db.execute(sql,self.id)
  end

  def self.db
    DB[:conn]
  end
end

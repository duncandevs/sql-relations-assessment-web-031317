class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id



  def customer
    #returns the customer of this review
    sql = <<-SQL
      SELECT * FROM customers WHERE customer_id = ?
    SQL
    Customer.db.execute(sql,self.customer_id)
  end

  def restaurant
    #returns the restaurant of this review
    sql = <<-SQL
      SELECT * FROM customers WHERE customer_id = ?
    SQL
    Customer.db.execute(sql,self.customer_id)
  end

  def self.db
    DB[:conn]
  end

end

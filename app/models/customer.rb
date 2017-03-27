
# Custome#reviews
# returns all of the reviews written by that customer
# Owner#restaurants
# returns all restaurants belonging to that owner
# Restaurant#owner
# returns the owner of that restaurant
# Review#customer
# returns the customer of that review
# Review#restaurant
# returns the restaurant of that particular review
class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def self.all
    sql = <<-SQL
      SELECT * FROM customers
    SQL
    Customer.db.execute(sql)
  end

  def reviews
    sql = <<-SQL
      SELECT * FROM reviews WHERE reviews.customer_id = ?
    SQL
    Customer.db.execute(sql,self.id)
  end

  def restaurants
    sql = <<-SQL
      SELECT restaurants.* FROM restaurants
      INNER JOIN reviews ON reviews.restaurant_id = restaurants.id
      WHERE reviews.customer_id = ?
    SQL
    Customer.db.execute(sql, self.id)
  end

  def self.db
    DB[:conn]
  end
end

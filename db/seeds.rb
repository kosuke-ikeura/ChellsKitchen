# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

require "csv"

User.create!(name: 'test', email: 'test@test.com', password: 'testtest')
User.create!(name: 'suke', email: 'suke@suke.com', password: 'sukesukesuke')

CSV.foreach('db/sample.csv') do |info|
  Flavor.create!(:name => info[0], :purchase_price => info[1], :status => info[2], :image => info[3], :created_at => info[4], :updated_at => info[5], :user_id => info[6])
end

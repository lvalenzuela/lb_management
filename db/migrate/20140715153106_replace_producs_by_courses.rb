class ReplaceProducsByCourses < ActiveRecord::Migration
  def up
  	add_column :courses, :productpriceid, :integer
  	add_column :courses, :coursetemplateid, :integer
  	add_column :courses, :statusid, :integer
  	add_column :courses, :start_date, :date
  	add_column :courses, :location, :string
    add_column :courses, :moodleid, :integer
  	remove_column :courses, :bookname
  	rename_column :courses, :max_students, :students_qty

  	rename_column :quotation_products, :productid, :courseid
  end

  def down
  	remove_column :courses, :productpriceid
  	remove_column :courses, :coursetemplateid
  	remove_column :courses, :statusid
  	remove_column :courses, :start_date
  	remove_column :courses, :location
    remove_column :courses, :moodleid
  	add_column :courses, :bookname, :string
  	rename_column :courses, :students_qty, :max_students

  	rename_column :quotation_products, :courseid, :productid
  end
end

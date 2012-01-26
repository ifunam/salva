class UpdateInstructorsInSeminaries < ActiveRecord::Migration
  def self.up
    Seminary.all.each do |seminary|
      instructors = seminary.user_seminaries.where(:roleinseminary_id => 2).collect {|record| record.user.author_name }.join(', ')
      if instructors.strip.empty?  and seminary.user_seminaries.size > 0
        instructors = seminary.user_seminaries.first.user.author_name 
      end
      unless instructors.strip.empty?
        seminary.instructors = instructors.to_s
        seminary.save
      end
    end
  end

  def self.down
    puts "Execute this query in your database: UPDATE seminaries SET instructors = NULL;"
  end
end

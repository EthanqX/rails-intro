class Movie < ActiveRecord::Base

  def self.all_ratings
    Movie.pluck(:rating).uniq
  end

  def self.with_ratings(ratings, sort_by)
    if sort_by.nil?
      Movie.all.order(sort_by)
    else
      Movie.where(rating: ratings).order(sort_by)
    end
  end

end
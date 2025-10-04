class Movie < ActiveRecord::Base
  # e.g., ["G", "PG", "PG-13", "R"]
  def self.all_ratings
    distinct.order(:rating).pluck(:rating).compact
  end

  # Case-insensitive filter by an array of ratings (e.g., ["g","R"])
  def self.with_ratings(ratings_array)
    return all if ratings_array.blank?
    downs = Array(ratings_array).map { |r| r.to_s.downcase }
    where('LOWER(rating) IN (?)', downs)
  end
end

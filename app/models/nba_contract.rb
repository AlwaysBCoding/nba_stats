class NbaContract < ActiveRecord::Base
# ASSOCIATIONS
  belongs_to :nba_player

# QUERY METHODS
  def years_remaining
    return 7 if salary_2020 != 0
    return 6 if salary_2019 != 0
    return 5 if salary_2018 != 0
    return 4 if salary_2017 != 0
    return 3 if salary_2016 != 0
    return 2 if salary_2015 != 0
    return 1 if salary_2014 != 0
  end

  def salary_remaining
    salary_2014 + salary_2015 + salary_2016 + salary_2017 + salary_2018 + salary_2019 + salary_2020
  end

end

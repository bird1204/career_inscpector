class TurnoverRate < ScoreDetail
  # 離職率
  def self.median
    array = []
    find_each(:batch_size => 1000) do |rate|
      array << rate.number if rate.number.present?
    end
    array = array.sort!

    elements = array.count
    return 0 if elements < 1
    center =  elements / 2
    return elements.even? ? (array[center - 1] + array[center])/2 : array[center - 1]
  end
end

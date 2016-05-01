class TurnoverRate < ScoreDetail
  # 離職率
  def self.median
    array = []
    find_each(:batch_size => 1000) do |rate|
      array << rate.number
    end
    array = array.sort!
    elements = array.count
    center =  elements / 2
    return elements.even? ? (array[center] + array[center+1])/2 : array[center]
  end
end

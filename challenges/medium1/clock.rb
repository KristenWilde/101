=begin
- Whatever is returned by Clock.at(num) can have an integer
  added, and the minutes increase.
- Need to be able to do math with the hours and minutes, 
  so save as instance variables.
- at method calls initialize method.
- equality method probably needed.
  
=end

class Clock
  def self.at(hours, mins=0)
    self.new(hours, mins)
  end

  def to_s
    format('%02i:%02i', @hours, @mins)
  end

  def +(minutes)
    hours_to_add, mins_to_add = minutes.divmod(60)

    @mins += mins_to_add
    @hours += hours_to_add % 24
    @hours = 0 if @hours == 24
    self
  end

  def -(minutes)
    hours_less, mins_less = minutes.divmod(60)

    @mins -= mins_less
    if @mins < 0
      @mins += 60
      @hours -= 1
    end

    @hours -= hours_less % 24
    @hours += 24 if @hours < 0
    self
  end

  def ==(other_clock)
    self.to_s == other_clock.to_s
  end

  private

  def initialize(hours, mins)
    @hours = hours
    @mins = mins
  end
end


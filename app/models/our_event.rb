class OurEvent < Event
  def self.all
    EventbriteFetcher.new.call
  end
end

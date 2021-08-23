module Debug
  def who_am_i? # Экземпляр метода
    "#{self.class.name} (id: #{self.object_id})"
  end
end
class Test
  include Debug # Примешивание модуля Debug
end
test = Test.new
pp test.who_am_i?


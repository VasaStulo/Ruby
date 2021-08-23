# frozen_string_literal: true
# require'../lib/records'
require 'date'
# class Record
class Record
  attr_accessor :cellphone, :status, :home_phone, :address
  attr_reader :birthday, :surname, :patronymic, :name, :sex

  def initialize(name, surname, patronymic, cellphone,
                 home_phone, address, birthday, sex, status)
    @name = name
    @surname = surname
    @patronymic = patronymic
    @cellphone = cellphone
    @home_phone = home_phone
    @address = address
    @birthday = Date.parse(birthday)
    @sex = sex
    @status = status
  end

  def to_s
    "#{@name},#{@surname},#{@patronymic},#{@cellphone},#{@home_phone},#{@address},#{@birthday},#{@sex},#{@status}"
  end

  def birthday_month
    birthday.mon
    return birthday.mon
  end

  def contacts
    (Date.today - birthday).to_i/365
    return (Date.today - birthday).to_i/365
  end



end

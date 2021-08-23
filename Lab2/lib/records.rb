# frozen_string_literal: true

require 'csv'
require 'date'
require_relative 'record'

# class Records
class Records

  attr_reader :records_list

  def initialize
    @records_list = []
  end

  def read_in_csv_data(file_name)
    CSV.foreach(file_name, headers: false) do |row|
      record = Record.new(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8])
      @records_list.push(record)
    end
  end

  # 1 point menu
  def add_new_record(data)
    @records_list.push(Record.new(data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8]))
    File.open('../data/input.csv', 'a') do |file|
      file.write("\n")
      file.write(@records_list[@records_list.length - 1])
    end
  end

  def is_exist_cellphone(phone)
    @records_list.each do |record|
      return true if record.cellphone == phone
    end
    false
  end

  def delete_element(phone_number)
    @records_list.each do |record|
      @records_list.delete(record) if record.cellphone == phone_number
    end
    write_and_recording
  end

  def write_and_recording
    File.open('../data/input.csv', 'w+') do |file|
      @records_list.each do |record|
        file.write(record)
        file.write("\n") unless record == @records_list[@records_list.length - 1]
      end
    end
  end

  # 2 point menu
  def change_attribute_of_element(cellphone, new_attribute, change_variable)
    change_record = nil

    @records_list.each do |record|
      change_record = record if record.cellphone == cellphone
    end

    change_record.address = new_attribute if change_variable == '1'
    change_record.cellphone = new_attribute if change_variable == '2'
    change_record.home_phone = new_attribute if change_variable == '3'
    change_record.status = new_attribute if change_variable == '4'
    write_and_recording
  end

  # 3 point menu
  # def sort_date_by_month
  #   @records_list.sort do |a, b|
  #     a.birthday.to_s.split('-')[1].to_i <=> b.birthday.to_s.split('-')[1].to_i
  #   end
  # end

    def sort_date_by_month()
      # @records_list.sort do |a,b|
      #   a.birthday.mon<=>b.birthday.mon
      @records_list.sort do |a,b|
        a.birthday_month<=>b.birthday_month
      end
    end

  # 4 point menu
  def statuses
    statuses_list = []
    @records_list.each do |record|
      statuses_list.push(record.status) unless statuses_list.include? record.status
    end
    statuses_list
  end

  def list_of_invitees_by_status(choice)
    list_of_invitees = []
    @records_list.each do |record|
      list_of_invitees.push(record) if record.status == choice
    end
    list_of_invitees
  end

  def list_of_guests(list_of_invitees, path, file)
    Dir.mkdir(path.to_s) unless File.exist?(path.to_s)
    list_of_invitees.each do |_invitation|
      File.open("#{path}/#{file}.txt", 'w+') do |file|
        list_of_invitees.each do |guest|
          file.write(guest)
          file.write("\n")
        end
      end
    end
  end

  def creating_invitations_file(holiday, list_of_invitees, path)
    Dir.mkdir("#{path}/invitations") unless File.exist?("#{path}/invitations")
    list_of_invitees.each do |invitation|
      File.open("#{path}/invitations/#{invitation.surname}#{holiday}.txt", 'w+') do |file|
        file.write("#{invitation.name} #{invitation.patronymic}, приглашаю Вас на #{holiday}")
      end
    end
  end

  # 5 point menu
  def total_amount
    @records_list.length
  end

  def contacts_of_women
    contacts_of_women = 0
    @records_list.each do |record|
      contacts_of_women += 1 if record.sex == 'ж'
    end
    contacts_of_women
  end

  def contacts_of_men
    contacts_of_men = 0
    @records_list.each do |record|
      contacts_of_men += 1 if record.sex == 'м'
    end
    contacts_of_men
  end

  def contacts_under20
    under_twenty = 0
    @records_list.each do |record|
      under_twenty += 1 if record.contacts < 20
    end
    under_twenty
  end

  def contacts_20to30
    contacts_twenty_to_thihty = 0
    @records_list.each do |record|
      next unless record.contacts >= 20

      contacts_twenty_to_thihty += 1 if record.contacts <= 30
    end
    contacts_twenty_to_thihty
  end

  def contacts_30to40
    contacts_thihty_to_forty = 0
    @records_list.each do |record|
      next unless record.contacts >= 30

      contacts_thihty_to_forty += 1 if record.contacts <= 40
    end
    contacts_thihty_to_forty
  end

  def contacts_over40
    contacts_over_forty = 0
    @records_list.each do |record|
      contacts_over_forty += 1 if record.contacts > 40
    end
    contacts_over_forty
  end

  def count_statuses(status)
    count = 0
    @records_list.each do |record|
      count += 1 if record.status == status
    end
    count
  end

  def count_by_home_phone(home_telephone)
    count_phone = 0
    @records_list.each do |record|
      count_phone += 1 if record.home_phone == home_telephone
    end
    count_phone
  end

  def count_by_address(adr)
    count_adr = 0
    @records_list.each do |record|
      count_adr += 1 if record.address == adr
    end
    count_adr
  end
end

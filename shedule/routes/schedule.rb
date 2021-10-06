# frozen_string_literal: true

# Routes for the cool books of this application
class ScheduleApplication
  path :schedule, '/schedule'
  path :group_all, '/schedule/by_groups'
  path :group do |name|
    "/schedule/by_groups/#{name}"
  end
  path :teacher_all, '/schedule/by_teachers'
  path :teacher do |name|
    "/schedule/by_teachers/#{name}"
  end

  opts[:lessons] = LessonList.new
  opts[:groups] = GroupList.new(opts[:lessons].all_lessons)

  hash_branch('schedule') do |r|
    append_view_subdir('schedule')

    r.is do
      view('navigation')
    end

    r.on 'by_groups' do
      r.is do
        @parameters = DryResultFormeWrapper.new(GroupFilterFormSchema.call(r.params))
        @filter_groups = if @parameters.success?
                           opts[:groups].filter_group(@parameters[:name])
                         else
                           opts[:groups].all_groups
                         end
        view('groups_all')
      end

      r.on String do |group_name|
        @group_name = Rack::Utils.unescape(group_name)
        @shedule = opts[:lessons].get_shedule(@group_name)
        if opts[:groups].in_group(@group_name)
          view('group_schedule')
        else
          view('not_exist_group')
        end
      end
    end
  end
end

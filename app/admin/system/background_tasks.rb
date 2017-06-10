ActiveAdmin.register BackgroundTask do

  menu parent: "System",  priority: 20
  actions :index, :show

  member_action :schedule_now, method: :post do
    resource.update_attributes run_at: Time.now
    redirect_to action: :index
  end

  action_item :schedule_now, only: :show do
      link_to 'Schedule now', schedule_now_background_task_path(resource), method: :post, title: 'shedule now', data: { confirm: 'Are you sure?' }
  end


end
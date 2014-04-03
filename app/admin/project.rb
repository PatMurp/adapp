ActiveAdmin.register Project do
  belongs_to :user

  sidebar "Project Details", only: [:show, :edit] do
    ul do
      li link_to("calculations", admin_project_calculations_path(project))
    end
  end

  ActiveAdmin.register Calculation do
    belongs_to :project
  end
  
end

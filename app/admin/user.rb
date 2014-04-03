ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :superadmin

  # limit the user attributes shown
  index do
    column :email
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    column :updated_at
    column :superadmin
    default_actions
  end

  # limit user form to attributes below
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superadmin
    end
    f.actions
  end

  sidebar "User Details", only: [:show, :edit] do
    ul do
      li link_to("Projects", admin_user_projects_path(user))
    end
  end

  filter :email

end

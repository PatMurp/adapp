ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :superadmin

  index do
    column :email
    column :last_sign_in_at
    column :last_sign_in_ip
    column :created_at
    column :updated_at
    column :superadmin
    default_actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superadmin
    end
    f.actions
  end

end

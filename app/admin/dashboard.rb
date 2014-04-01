ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
    end

    # display recently added feedstocks
    panel "Recently Added Feedstocks" do
      table_for Feedstock.order("created_at DESC").limit(5) do
        column "Feedstock", :type do |feedstock|
          link_to feedstock.type, [:admin, feedstock]
        end
        column :created_at
      end
      strong { link_to "View all Feedstocks", admin_feedstocks_path }
    end

    # display recently signed up users
    panel "Recently Signed up Users" do
      table_for User.order("created_at DESC").limit(5) do
        column :email do |user|
          link_to user.email, [:admin, user]
        end
        column :created_at
      end
      strong { link_to "View all Users", admin_users_path }
    end
  end 
end

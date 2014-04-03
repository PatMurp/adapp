ActiveAdmin.register Feedstock do
  permit_params :type, :biogas_per_tonne, :methane_percent, :digestate_percent

  index do
    column "Feedstock", :type
    column :biogas_per_tonne
    column :methane_percent
    column :digestate_percent
    default_actions
  end

  filter :type

end

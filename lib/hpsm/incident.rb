module Hpsm
  class Incident
    attr_accessor :incident_id, :service, :category, :urgency, :assignment_group,
                  :description, :area, :sub_area, :title, :impact
  end
end
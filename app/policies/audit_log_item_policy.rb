# frozen_string_literal: true

class AuditLogItemPolicy < ::RolePolicy
  section 'AuditLogItem'

  class Scope < ::RolePolicy::Scope
  end
end

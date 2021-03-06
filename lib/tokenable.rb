require 'active_support/concern'

module Tokenable
  extend ActiveSupport::Concern

  included do
    def generate_token
      begin
        self.token = SecureRandom.urlsafe_base64
      end while self.class.exists?(token: token)
    end

    def expired?
      begin
        Time.zone.now > self.expires_at
      rescue
        # No expires_at field, assumed infinite
        false
      end
    end

    def invalid?
      expired? || used
    end

    def mark_used
      update_attributes(used: true)
    end

    def set_expires_at
      lifespan = self.class.const_get(:LIFESPAN)
      self.expires_at ||= lifespan.from_now
    end
  end

end
